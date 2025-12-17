import 'dart:convert';

class HomeDummy {
////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
  static final Map<String, dynamic> reels = {
    'isSuccess': true,
    'statusCode': 200,
    'data': [
      for (var i = 0; i < 3; i++)
      {
        'id': '47e1e46f-e683-4e31-ac37-b9583ae728f0',
        'presignedUrl':
            'https://amaan-videos.s3.eu-south-1.wasabisys.com/wamaan-videos/e9c5fb8f-e7a5-408a-9f88-717db3ce20f3/47e1e46f-e683-4e31-ac37-b9583ae728f0.mp4?X-Amz-Expires=7200&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=9O3JITCJCQ7SOJB1FO59%2F20241221%2Feu-south-1%2Fs3%2Faws4_request&X-Amz-Date=20241221T182322Z&X-Amz-SignedHeaders=host&X-Amz-Signature=e655312d883930256fa92ac3cc87c633313cdfbeaf9990de4f272199d4de1510',
        'imageUrl':
            'https://github.com/user-attachments/assets/a3bbb9f9-73f9-4da8-b5dd-66b051cb323e',
        'videoName': '47e1e46f-e683-4e31-ac37-b9583ae728f0.mp4',
        'title': null,
        'description': null,
        'videoType': null
      }
    ],
    'pagination': null,
    'error': null,
    'errorMessage': null
  };

////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
  static final Map<String, dynamic> categories = jsonDecode('''{
  "isSuccess": true,
  "statusCode": 200,
  "data": [
    {
      "id": "37badf64-9276-4a52-a5d2-89249727418d",
      "name": "Islamic",
      "description": "Islamic",
      "image": {
        "id": "1248e695-ba20-4d10-aa22-b5d232e0c798",
        "name": "maqtsia026 (2).png",
        "url": "qcqpnjudxuhbqy320q7l.png"
      },
      "backgroundImage": {
        "id": "204d1866-b1db-4f85-8d74-02a5277090bb",
        "name": "2.jpg",
        "url": "dqodunlq9l8ddxsyiv5c.png"
      }
    },
    {
      "id": "string",
      "name": "movies",
      "description": "movies",
      "image": {
        "id": "e23cd9ca-d2b5-498c-81ef-2c1d35442742",
        "name": "image 64.png",
        "url": "e7yaiggfyi4orrxoafqj.png"
      },
      "backgroundImage": {
        "id": "ffde0677-399b-4058-8e17-18e5b0575117",
        "name": "ddd.png",
        "url": "occedmkplqmhfwocrgdo.png"
      }
    },
    {
      "id": "545c9ba4-dc17-4d82-a635-e2f536327efc",
      "name": "action 2",
      "description": "action 2",
      "image": {
        "id": "33eede1b-db7f-4e13-b52a-d7657e40ef71",
        "name": "adorable-boy-fantasy-world (2) 2.png",
        "url": "fe7qqqdltnkcbzv63mrd.png"
      },
      "backgroundImage": {
        "id": "9c40d429-2525-4501-b161-480b3b0e7a58",
        "name": "12.png",
        "url": "bd6xiy4ri9k21uwxafso.png"
      }
    }
  ],
  "pagination": null,
  "error": null,
  "errorMessage": null
} ''');

////////////////////////////////////////////////////
////////////////////////////////////////////////////
////////////////////////////////////////////////////
  static final Map<String, dynamic> continueWatching = jsonDecode('''{
  "isSuccess": true,
  "statusCode": 200,
  "data": [
    {
      "id": "eee38c3c-7f5b-4e18-858d-371326c50839",
      "title": "The Shop series",
      "duration": "3720",
      "thumbnailImageId": "68ab3f90-e970-4530-9bba-d4732f55bcb1",
      "showTypeId": "4737eac3-7fdd-43ab-9087-f8cf6251377e",
      "fromMinute": "00:00:02.3700000",
      "isFavourite": false,
      "thumbnailImage": {
        "id": "68ab3f90-e970-4530-9bba-d4732f55bcb1",
        "name": "mos02.png",
        "url": "zzi5qanlpn2nskd7xja3.png"
      }
    },
    {
      "id": "eee38c3c-7f5b-4e18-858d-371326c50839",
      "title": "The Shop series",
      "duration": "3720",
      "thumbnailImageId": "68ab3f90-e970-4530-9bba-d4732f55bcb1",
      "showTypeId": "4737eac3-7fdd-43ab-9087-f8cf6251377e",
      "fromMinute": "00:00:02.3700000",
      "isFavourite": false,
      "thumbnailImage": {
        "id": "68ab3f90-e970-4530-9bba-d4732f55bcb1",
        "name": "mos02.png",
        "url": "zzi5qanlpn2nskd7xja3.png"
      }
    }
  ],
  "pagination": null,
  "error": null,
  "errorMessage": null
}''');

  static final Map<String, dynamic> topShows = jsonDecode('''{
  "isSuccess": true,
  "statusCode": 200,
  "data": {
    "topShows": [
      {
        "id": "00840b5e-79eb-4d58-9a09-41ad42f2f4d7",
        "title": "New version ",
        "duration": "6420",
        "thumbnailImageId": "315f8588-370f-4eff-8840-1f7d39436eb4",
        "isFavourite": false,
        "isFree": true,
        "isGuest": true,
        "releaseDate": "2024-12-04T14:00:00+00:00",
        "showType": {
          "id": "43242b9b-0fa4-4ed9-a8c0-12d512d1dbfe",
          "name": "Movie"
        },
        "thumbnailImage": {
          "id": "315f8588-370f-4eff-8840-1f7d39436eb4",
          "name": "3 (1).jpg",
          "url": "afkzgqa2cnnohqv16bra.jpg"
        }
      },
      {
        "id": "52e9641e-a962-4b9d-ad66-905125881bf7",
        "title": "Smart ball",
        "duration": "0",
        "thumbnailImageId": "d5918a6a-93d2-4cb5-be24-300f6c91705a",
        "isFavourite": false,
        "isFree": true,
        "isGuest": true,
        "releaseDate": "2024-11-29T09:25:00+00:00",
        "showType": {
          "id": "43242b9b-0fa4-4ed9-a8c0-12d512d1dbfe",
          "name": "Movie"
        },
        "thumbnailImage": {
          "id": "d5918a6a-93d2-4cb5-be24-300f6c91705a",
          "name": "معدني 2.png",
          "url": "oaujsntvhnzyjeu4zgyq.png"
        }
      
      }
    ]
  },
  "pagination": null,
  "error": null,
  "errorMessage": null
} ''');
}
