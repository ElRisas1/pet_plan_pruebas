
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    tz.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(initSettings);
  }

  static Future<void> programarNotificacion({
    required int id,
    required String titulo,
    required String mensaje,
    required DateTime fechaHora,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'canal_recordatorios',
      'Recordatorios',
      channelDescription: 'Canal para notificaciones de recordatorios',
      importance: Importance.max,
      priority: Priority.high,
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await _plugin.zonedSchedule(
      id,
      titulo,
      mensaje,
      tz.TZDateTime.from(fechaHora, tz.local),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  static Future<void> guardarRecordatorioEnSharedPreferences({
    required int id,
    required String titulo,
    required String mensaje,
    required DateTime fechaHora,
    required String mascota,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final recordatorios = prefs.getStringList('recordatorios') ?? [];

    final recordatorio = {
      "id": id.toString(),
      "titulo": titulo,
      "mensaje": mensaje,
      "fecha": fechaHora.toIso8601String(),
      "mascota": mascota,
    };

    recordatorios.add(jsonEncode(recordatorio));
    await prefs.setStringList('recordatorios', recordatorios);
  }
}
