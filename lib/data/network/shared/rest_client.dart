import 'package:app_flutter_miban4/ui/widgets/dialogs/custom_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RestClient extends GetConnect {
  Future<T> getMethod<T>(
      String url, Map<String, String> headers, VoidCallback onCancel, VoidCallback onError,
      [Map<String, dynamic>? query, T Function(dynamic)? fromJson]) async {
    final response =
    await get(url, headers: headers, query: query, decoder: (body) {
      if (body is Map<String, dynamic> && fromJson != null) {
        if (body.containsKey('message') ||
            body.containsKey('message_error') ||
            body.containsKey('error_message')) {
          CustomDialogs.showInformationDialog(
              content: body['message'] ??
                  body['message_error'] ??
                  body['error_message'],
              onCancel: onCancel);
        }
        return fromJson(body);
      }
      return body;
    });
    if (response.hasError) {
      CustomDialogs.showInformationDialog(
          content: 'button_connection'.tr, onCancel: onError);
      throw Exception('Failed to fetch data: ${response.statusText}');
    }
    return response.body;
  }

  Future<T> postMethod<T>(String url, Map<String, String> headers, dynamic body,
      VoidCallback onCancel, VoidCallback onError,
      [Map<String, dynamic>? query, T Function(dynamic)? fromJson]) async {
    final response =
    await post(url, body, headers: headers, query: query, decoder: (body) {
      if (body is Map<String, dynamic> && fromJson != null) {
        if (body.containsKey('message') ||
            body.containsKey('message_error') ||
            body.containsKey('error_message')) {
          CustomDialogs.showInformationDialog(
              content: body['message'] ??
                  body['message_error'] ??
                  body['error_message'],
              onCancel: onCancel);
        }
        return fromJson(body);
      }
      return body;
    });
    if (response.hasError) {
      CustomDialogs.showInformationDialog(
          content: 'button_connection'.tr, onCancel: onError);
      throw Exception('Failed to fetch data: ${response.statusText}');
    }
    return response.body;
  }

  Future<T> putMethod<T>(String url, Map<String, String> headers, dynamic body,
      VoidCallback onCancel, VoidCallback onError,
      [Map<String, dynamic>? query, T Function(dynamic)? fromJson]) async {
    final response =
    await put(url, body, headers: headers, query: query, decoder: (body) {
      if (body is Map<String, dynamic> && fromJson != null) {
        if (body.containsKey('message') ||
            body.containsKey('message_error') ||
            body.containsKey('error_message')) {
          CustomDialogs.showInformationDialog(
              content: body['message'] ??
                  body['message_error'] ??
                  body['error_message'],
              onCancel: onCancel);
        }
        return fromJson(body);
      }
      return body;
    });
    if (response.hasError) {
      CustomDialogs.showInformationDialog(
          content: 'button_connection'.tr, onCancel: onError);
      throw Exception('Failed to fetch data: ${response.statusText}');
    }
    return response.body;
  }

  Future<T> deleteMethod<T>(String url, Map<String, String> headers,
      Map<String, dynamic> query, VoidCallback onCancel, VoidCallback onError,
      [T Function(dynamic)? fromJson]) async {
    final response =
    await delete(url, headers: headers, query: query, decoder: (body) {
      if (body is Map<String, dynamic> && fromJson != null) {
        if (body.containsKey('message') ||
            body.containsKey('message_error') ||
            body.containsKey('error_message')) {
          CustomDialogs.showInformationDialog(
              content: body['message'] ??
                  body['message_error'] ??
                  body['error_message'],
              onCancel: onCancel);
        }
        return fromJson(body);
      }
      return body;
    });
    if (response.hasError) {
      CustomDialogs.showInformationDialog(
          content: 'button_connection'.tr, onCancel: onError);
      throw Exception('Failed to fetch data: ${response.statusText}');
    }
    return response.body;
  }
}