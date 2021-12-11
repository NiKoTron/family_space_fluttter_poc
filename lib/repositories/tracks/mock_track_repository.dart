import 'dart:convert';

import 'package:family_space_flutter/model/api_response.dart';
import 'package:family_space_flutter/model/coordinates.dart';
import 'package:family_space_flutter/model/track_data.dart';
import 'package:family_space_flutter/repositories/tracks/tracks_repository.dart';

class MockTrackRepository implements TracksRepository {
  @override
  Future<List<Coordinates>> getTrack() async =>
      ApiResponse<Map<String, TrackData>>.fromJson(
        json.decode(_mockedResponse),
        (j) => (j as Map<String, dynamic>).map<String, TrackData>(
          (key, value) => MapEntry<String, TrackData>(
            key,
            TrackData.fromJson(value as Map<String, dynamic>),
          ),
        ),
      ).result?.values.first.coordinatesHistory.values.toList() ??
      [];

  @override
  Future<String> getHomeAddress() async => 'ул. Николая Островского, 89';

  @override
  Future<Coordinates> getHomeLocation() async => Coordinates(
        latitude: 59.982316315315,
        longitude: 30.315298319102,
      );
}

const _mockedResponse = '''
{
  "error": 0,
  "errorText": "",
  "result": {
    "54765342": {
      "status": "approved",
      "latitude": "59.982316315315",
      "longitude": "30.315298319102",
      "accuracy": "35",
      "source": "0",
      "batteryLevel": "30",
      "steps": null,
      "turnovers": null,
      "warnings": "",
      "name": "",
      "birthdate": null,
      "gender": null,
      "parentName": null,
      "setCoordsTime": "2021-12-07 16:08:02+03:00",
      "healthCheckTime": "2021-12-07 16:08:02+03:00",
      "authCode": "hdzwx",
      "childId": "56224113",
      "deviceType": "ios",
      "watchType": "",
      "deviceToken": "9c122b15ea176f95e8f3c19d7bee319166aacfd150ccf4d7c6dd9929a68a187c",
      "deviceId": null,
      "devicePhoneNumber": "",
      "photo": null,
      "deviceUid": "ji2s7148da",
      "todoPoints": "0.00",
      "todoPointsGray": 0,
      "warningsWereSet": true,
      "unacceptedTasksQuantity": 0,
      "autoTasksState": false,
      "autoTasksAvailable": false,
      "isLocationReplaced": false,
      "lastNotIgnoredCoord": "2021-12-07 16:08:02+03:00",
      "coordinatesHistory": {
        "0": {
          "id": 0,
          "ts": "2021-12-07 10:01:49+03:00",
          "latitude": 59.982289722716168,
          "longitude": 30.315139558960606,
          "accuracy": 47,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": true
        },
        "1": {
          "id": 0,
          "ts": "2021-12-07 10:02:05+03:00",
          "latitude": 59.982201889981432,
          "longitude": 30.314335961591265,
          "accuracy": 6,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "2": {
          "id": 0,
          "ts": "2021-12-07 10:03:32+03:00",
          "latitude": 59.981910531227946,
          "longitude": 30.31357767882805,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "3": {
          "id": 0,
          "ts": "2021-12-07 10:03:51+03:00",
          "latitude": 59.981859186112821,
          "longitude": 30.312973749457647,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "4": {
          "id": 0,
          "ts": "2021-12-07 10:04:09+03:00",
          "latitude": 59.981977783199127,
          "longitude": 30.312622260591002,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "5": {
          "id": 0,
          "ts": "2021-12-07 10:07:47+03:00",
          "latitude": 59.982343303933234,
          "longitude": 30.309797877958097,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "6": {
          "id": 0,
          "ts": "2021-12-07 10:08:37+03:00",
          "latitude": 59.982800655343929,
          "longitude": 30.309012573500951,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "7": {
          "id": 0,
          "ts": "2021-12-07 10:08:59+03:00",
          "latitude": 59.982669090451502,
          "longitude": 30.309335311329015,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "8": {
          "id": 0,
          "ts": "2021-12-07 10:09:17+03:00",
          "latitude": 59.982488148894461,
          "longitude": 30.309589912275836,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "9": {
          "id": 0,
          "ts": "2021-12-07 10:09:36+03:00",
          "latitude": 59.982351675525877,
          "longitude": 30.309920482595508,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "10": {
          "id": 0,
          "ts": "2021-12-07 10:11:12+03:00",
          "latitude": 59.98208527577475,
          "longitude": 30.311659590289594,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "11": {
          "id": 0,
          "ts": "2021-12-07 10:12:28+03:00",
          "latitude": 59.981985188691972,
          "longitude": 30.313170257322447,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "12": {
          "id": 0,
          "ts": "2021-12-07 10:12:53+03:00",
          "latitude": 59.981941473992428,
          "longitude": 30.313309266415711,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "13": {
          "id": 0,
          "ts": "2021-12-07 10:16:46+03:00",
          "latitude": 59.981785320051912,
          "longitude": 30.313498392686466,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "14": {
          "id": 0,
          "ts": "2021-12-07 10:19:37+03:00",
          "latitude": 59.981896482677406,
          "longitude": 30.313574713710697,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "15": {
          "id": 0,
          "ts": "2021-12-07 10:21:05+03:00",
          "latitude": 59.982642931478729,
          "longitude": 30.314006748853433,
          "accuracy": 5,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "16": {
          "id": 0,
          "ts": "2021-12-07 10:21:21+03:00",
          "latitude": 59.982680726606873,
          "longitude": 30.314751319519793,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "17": {
          "id": 0,
          "ts": "2021-12-07 10:33:45+03:00",
          "latitude": 59.982348984516094,
          "longitude": 30.31508123284905,
          "accuracy": 4,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "18": {
          "id": 0,
          "ts": "2021-12-07 10:41:12+03:00",
          "latitude": 59.982304378645154,
          "longitude": 30.315102057125632,
          "accuracy": 38,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": false
        },
        "19": {
          "id": 0,
          "ts": "2021-12-07 16:08:02+03:00",
          "latitude": 59.982323926699387,
          "longitude": 30.31530474152542,
          "accuracy": 36,
          "source": 0,
          "course": 0,
          "altitude": 0,
          "speed": 0,
          "activityType": "UNKNOWN",
          "isReferencePoint": true
        },
        "20": {
          "accuracy": 35,
          "activityType": "3",
          "altitude": 59.984272003173999,
          "course": -1,
          "latitude": 59.982316315315003,
          "longitude": 30.315298319101998,
          "source": "0",
          "speed": -1,
          "ts": "2021-12-07 16:08:02+03:00",
          "ts_start": "2021-12-07 16:08:02+03:00",
          "isLocationReplaced": false
        }
      },
      "routeAnalytics": {
        "CoordsCount": 104,
        "UniqKeysCount": 9,
        "TimeDelta": 22275,
        "RouteComplete": 1,
        "TimeSpendInLastUniqKey": 3843,
        "StartPoint": {
          "latitude": 59.982308764124284,
          "longitude": 30.315220945984358
        },
        "EndPoint": {
          "latitude": 59.98231631531516,
          "longitude": 30.315298319102403
        }
      },
      "settings": {
        "lbsUsing": {
          "tsUpdate": "",
          "value": "1"
        },
        "walkingTimeIntervals": {
          "tsUpdate": "",
          "value": "00:00-00:00,00:00-00:00,00:00-00:00"
        },
        "child_age_interval": {
          "value": "18"
        },
        "child_age_value": {
          "value": "25"
        },
        "childHasSeenGeoPermissionScreen": {
          "value": "0"
        },
        "geoVersion": {
          "value": "new"
        },
        "hasNewEvents": {
          "value": "2021-12-06 22:55:43+03:00"
        },
        "hasNotActualDeviceToken": {
          "value": "0"
        },
        "ios_app_version": {
          "value": "9541"
        },
        "lastBLevent": {
          "value": "2021-12-06 22:55:43"
        },
        "pushRequestCoordinate": {
          "value": "0"
        },
        "reg_ipc": {
          "value": "RU"
        },
        "sos": {
          "value": "0"
        },
        "timeZone": {
          "value": "180"
        },
        "warningsWereSet": {
          "value": "1"
        }
      },
      "cwpDeleted": false,
      "placesQuantity": 0
    }
  },
  "ts": "2021-12-07 16:08:37+03:00",
  "objectsData": {
    "user": {
      "56224113": {
        "id": "56224113",
        "ts": "2021-10-28 16:37:22+03:00",
        "ts_update": "2021-10-28 16:37:22+03:00",
        "phone": null,
        "timeDelta": 969,
        "type": "child",
        "licenseTo": null,
        "isTrial": false,
        "monthForRepostUsed": "0",
        "monthForQuizUsed": "0",
        "warnings": null,
        "locale": "en-US",
        "serverDate": "2021-12-07 16:08:37+03:00",
        "licenseBasis": null,
        "__order": 1
      }
    }
  },
  "b": "megab1.findmykids.org"
}''';
