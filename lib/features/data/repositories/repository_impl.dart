import 'package:dartz/dartz.dart';

import '../../../core/network/network_info.dart';
import '../../../error/exceptions.dart';
import '../../../error/failures.dart';
import '../../domain/repositories/repository.dart';
import '../data_sources/local_data_sources.dart';
import '../data_sources/remote_data_sources.dart';
import '../models/request/verify_otp_request.dart';
import '../models/response/promotions_response.dart';
import '../models/response/send_otp_response.dart';
import '../models/response/verify_otp_response.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;
  RepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, SendOtpResponse>> sendOtpRequest(params) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource
            .sendOtpRequest(params);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, VerifyOtpResponse>> verifyOtp(VerifyOtpRequest verifyOtp) async {
    if (await networkInfo.isConnected) {
      try {
        final parameters = await remoteDataSource
            .verifyOtp(verifyOtp);
        return Right(parameters);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, List<PromotionsResponse>>> getPromotions() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPromotions();
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(e.errorResponseModel));
      } on UnAuthorizedException catch (e) {
        return Left(AuthorizedFailure(e.errorResponseModel));
      }
    } else {
      return Left(ConnectionFailure());
    }
  }


}