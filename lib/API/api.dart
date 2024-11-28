import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:todolists/constants.dart' as constants;
import '../providers/listprovider.dart';
class API {
  final dio = Dio();

  Future<void> fetchData(context) async {
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers["Authorization"] = "Bearer ${Provider.of<ListProvider>(context, listen: false).getAccessToken}";
        return handler.next(options);
      },
      onError: (error, handler) async {
        if (error.response?.statusCode==401){
          await accessToken(context);
          dio.options.headers["Authorization"] = "Bearer ${Provider.of<ListProvider>(context, listen: false).getAccessToken}";
          return handler.resolve(await dio.fetch(error.requestOptions));
        }
        return handler.next(error);
      }
    ));
    final fetchResponse =
    await dio.get(constants.dataUrl);
    Provider.of<ListProvider>(context, listen: false).setTodos(fetchResponse.data["value"]);
  }

  Future<void> saveData(context) async {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Authorization"] = "Bearer ${Provider.of<ListProvider>(context, listen: false).getAccessToken}";
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode==401){
            await accessToken(context);
            dio.options.headers["Authorization"] = "Bearer ${Provider.of<ListProvider>(context, listen: false).getAccessToken}";
            return handler.resolve(await dio.fetch(error.requestOptions));
          }
          return handler.next(error);
        }
    ));
    await dio.post(constants.dataUrl,
    data: {
      "title": Provider.of<ListProvider>(context, listen: false)
          .getTitle,
      "body": {"content":  Provider.of<ListProvider>(context, listen: false)
          .getDescription}
    });
  }

  Future<void> editData(context) async {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Authorization"] = "Bearer ${Provider.of<ListProvider>(context, listen: false).getAccessToken}";
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode==401){
            await accessToken(context);
            dio.options.headers["Authorization"] = "Bearer ${Provider.of<ListProvider>(context, listen: false).getAccessToken}";
            return handler.resolve(await dio.fetch(error.requestOptions));
          }
          return handler.next(error);
        }
    ));
    await dio.put("${constants.dataUrl}/${Provider.of<ListProvider>(context, listen: false).getId}",
        data: {
          "title": Provider.of<ListProvider>(context, listen: false)
              .getTitle,
          "body": {"content":  Provider.of<ListProvider>(context, listen: false)
              .getDescription}
        });
  }

  Future<void> deleteData(context) async {
    dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          options.headers["Authorization"] = "Bearer ${Provider.of<ListProvider>(context, listen: false).getAccessToken}";
          return handler.next(options);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode==401){
            await accessToken(context);
            dio.options.headers["Authorization"] = "Bearer ${Provider.of<ListProvider>(context, listen: false).getAccessToken}";
            return handler.resolve(await dio.fetch(error.requestOptions));
          }
          return handler.next(error);
        }
    ));
    await dio.delete("${constants.dataUrl}/${Provider.of<ListProvider>(context, listen: false).getId}");
    Provider.of<ListProvider>(context, listen: false).randomColorDelete();
  }

Future<void> accessToken(context) async {
    final tokenResponse = await dio.post(constants.tokenUrl,
        data: {
          "grant_type": "client_credentials",
          "scope": "https://graph.microsoft.com/.default",
          "client_id": constants.clientID,
          "client_secret": constants.clientSecret,
        },
        options: Options(
            contentType:  Headers.formUrlEncodedContentType
        )
        );
    Provider.of<ListProvider>(context, listen: false).setAccessToken(tokenResponse.data["access_token"]);
}
}