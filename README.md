# colosseum_guide

A new Flutter project.

## Audio Download System — Technical Proposal

### Overview

8 audio files hosted on Google Cloud Storage. App downloads them to device storage on first launch. User sees real-time progress. After download, audio plays offline via `just_audio`.

**Benefits:**
- Smaller app bundle (audio not shipped in APK)
- Audio content can be updated without app store release
- User sees download progress and can retry on failure
- Offline playback after download completes

---

### Architecture

```
+------------------+     HTTPS      +---------------------------+
|  Google Cloud    | ============>  |  AudioDownloadService     |
|  Storage Bucket  |                |  (dio + path_provider)    |
|  /audio/*.mp3    |                +------------+--------------+
+------------------+                             |
                                                 v
                                    +---------------------------+
                                    |  Device Storage           |
                                    |  app_docs/audio/*.mp3     |
                                    +------------+--------------+
                                                 |
                                                 v
                                    +---------------------------+
                                    |  just_audio AudioPlayer   |
                                    |  setFilePath(localPath)   |
                                    +---------------------------+
```

---

### New Dependencies

Add to `pubspec.yaml`:

```yaml
dependencies:
  dio: ^5.4.0            # HTTP client with download progress
  path_provider: ^2.1.0  # Access to app documents directory
```

Existing packages reused:
- `just_audio` — audio playback from local file path
- `hive_flutter` — cache download status (optional)

---

### Implementation Steps

#### Step 1 — Upload Audio to Google Cloud Storage

Upload 8 MP3 files to a GCS bucket.

```bash
# Create bucket
gsutil mb gs://colosseum-guide-audio

# Upload files
gsutil cp *.mp3 gs://colosseum-guide-audio/

# Make publicly accessible
gsutil iam ch allUsers:objectViewer gs://colosseum-guide-audio
```

Verify access in browser:
```
https://storage.googleapis.com/colosseum-guide-audio/01_entrance.mp3
```

#### Step 2 — Create AudioDownloadService

Create `lib/core/services/audio_download_service.dart`:

```dart
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

class AudioDownloadService {
  final Dio _dio = Dio();
  static const _baseURL =
      'https://storage.googleapis.com/colosseum-guide-audio';

  // 8 audio files mapped to guide_data points
  static const audioFiles = [
    '01_entrance.mp3',
    '02_arena.mp3',
    '03_hypogeum.mp3',
    '04_upper_tier.mp3',
    '05_corridor.mp3',
    '06_sunset.mp3',
    '07_extra.mp3',
    '08_extra.mp3',
  ];

  Future<String> localPath(String filename) async {
    final dir = await getApplicationDocumentsDirectory();
    return '${dir.path}/audio/$filename';
  }

  Future<bool> isDownloaded(String filename) async {
    return File(await localPath(filename)).existsSync();
  }

  Future<bool> isAllDownloaded() async {
    for (final f in audioFiles) {
      if (!await isDownloaded(f)) return false;
    }
    return true;
  }

  /// Returns overall progress 0.0 to 1.0
  Stream<double> downloadAll() async* {
    final total = audioFiles.length;
    var completed = 0;

    for (final filename in audioFiles) {
      if (await isDownloaded(filename)) {
        completed++;
        yield completed / total;
        continue;
      }

      final savePath = await localPath(filename);
      await Directory(File(savePath).parent.path).create(recursive: true);

      await _dio.download(
        '$_baseURL/$filename',
        savePath,
        onReceiveProgress: (received, totalBytes) {
          // per-file progress: received / totalBytes
        },
      );

      completed++;
      yield completed / total;
    }
  }

  Future<void> deleteAll() async {
    for (final f in audioFiles) {
      final path = await localPath(f);
      final file = File(path);
      if (file.existsSync()) file.deleteSync();
    }
  }
}
```

#### Step 3 — Wire Progress to DownloadAudioScreen

Replace fake `_progress = 0.42` with real stream:

```dart
class _DownloadAudioScreenState extends State<DownloadAudioScreen> {
  final _downloadService = AudioDownloadService();
  double _progress = 0.0;
  String _currentFile = '';
  bool _isDownloading = false;
  String? _error;

  Future<void> _startDownload() async {
    setState(() {
      _isDownloading = true;
      _error = null;
    });

    try {
      await for (final progress in _downloadService.downloadAll()) {
        if (mounted) {
          setState(() => _progress = progress);
        }
      }
      if (mounted) {
        // Download complete - navigate to guide
        context.goNamed(guidedSpotsViewName);
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isDownloading = false;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _startDownload();
  }
}
```

#### Step 4 — Update guide_data.dart

Change `narrationAudio` from full asset path to filename only:

| Tour Point ID | CURRENT | NEW |
|---|---|---|
| `entrance` | `assets/audio/01_entrance.mp3` | `01_entrance.mp3` |
| `arena_floor` | `assets/audio/02_arena.mp3` | `02_arena.mp3` |
| `hypogeum` | `assets/audio/03_hypogeum.mp3` | `03_hypogeum.mp3` |
| `upper_tier` | `assets/audio/04_upper_tier.mp3` | `04_upper_tier.mp3` |
| `corridor` | `assets/audio/05_corridor.mp3` | `05_corridor.mp3` |
| `exit_view` | `assets/audio/06_sunset.mp3` | `06_sunset.mp3` |
| `tour_extra_1` | `assets/audio/07_extra.mp3` | `07_extra.mp3` |
| `tour_extra_2` | `assets/audio/08_extra.mp3` | `08_extra.mp3` |

#### Step 5 — Update Audio Player Logic

In guided_spots_details screen, resolve local path before playing:

```dart
Future<void> _loadAudio(String narrationAudio) async {
  final downloadService = AudioDownloadService();

  if (await downloadService.isDownloaded(narrationAudio)) {
    // Play from downloaded local file
    final path = await downloadService.localPath(narrationAudio);
    await _player.setFilePath(path);
  } else {
    // Fallback: play from bundled asset
    await _player.setAsset('assets/audio/$narrationAudio');
  }
}
```

---

### Timeline

| Phase | Description | Tech |
|---|---|---|
| **Phase 1**: Upload + Service | Upload 8 files to GCS. Create `AudioDownloadService`. | `dio`, `path_provider` |
| **Phase 2**: UI Wiring | Connect real progress stream to `DownloadAudioScreen`. Add error handling + retry. | Update existing screen |
| **Phase 3**: Data Update | Update `guide_data.dart` fields. Update audio player to use local path. | `guide_data.dart` + player |
| **Phase 4**: Testing | Test download on iOS + Android. Test offline playback. Test retry on failure. | Device testing |
| **Phase 5**: Polish | Add download status persistence (Hive). Skip download screen if already downloaded. | Hive cache integration |

---

### GCS Security Notes

- **Public bucket**: simplest, audio is non-sensitive content
- **Signed URLs**: time-limited access, more secure, requires backend to generate URLs
- **Firebase Storage**: alternative if already using Firebase, built-in Flutter integration

---

## Getting Started (Flutter)

This project is a starting point for a Flutter application.

- [Lab: Write your first app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/).


=== Track _ 00
https://drive.usercontent.google.com/download?id=1Gk5iRU2UQ6LwIKJcpFJvyttqE9opHe9Q&export=download&authuser=0&confirm=t&uuid=46795023-1bae-4e61-bc5b-3c10804f2b6c&at=ABswASYDgGD4aJbfUIdTelc1HnLm:1784958606076

=== Track _ 01
https://drive.usercontent.google.com/download?id=1piHMYtdWGwpo-bGptpwEgskBvKkf9lQB&export=download&authuser=0&confirm=t&uuid=b2ee598b-8809-45bd-876d-f4268391d35e&at=ABswASblJPRhVpqFrHerbh2cs51b:1784958770434

=== Track _ 02
https://drive.usercontent.google.com/download?id=16ZvRnRUQXZ13Ppr7VHekFEwRUDWA-76a&export=download&authuser=0&confirm=t&uuid=d0faffba-74c0-499c-ac6f-5b7cd54aac77&at=ABswASbOhA6vO8nAYp1dpCq8R-NR:1784958805858

=== Track _ 03
https://drive.usercontent.google.com/download?id=1LngyPnrdlWbWmxZsxepvm2kAJek4MmfN&export=download&authuser=0&confirm=t&uuid=835acf79-c405-4ef9-832d-27803c056edb&at=ABswASa71SxaS6Vjvtb6tTYosh98:1784958895160

=== Track _ 04
https://drive.usercontent.google.com/download?id=1EL17lvIEMfyaVyo2WW6SdReS6JKdobhB&export=download&authuser=0&confirm=t&uuid=b33d1fe5-3431-4665-ab6f-95e30328ead8&at=ABswASZtpsRa-j8nA1p66TltOEfC:1784958958909


=== Track _ 05
https://drive.usercontent.google.com/download?id=1D0shWDqqwgEl52o9Y-aneKa0iUMKg4G-&export=download&authuser=0&confirm=t&uuid=fd3eb8a5-05ef-4015-bcc9-69d7118756b4&at=ABswASZZdfyILITJBq39PDDSIPWi:1784959006777

=== Track _ 06
https://drive.usercontent.google.com/download?id=1-4yzZRwX5g52TJzr47B8gDe_fyHMWvVu&export=download&authuser=0&confirm=t&uuid=8d661923-df45-42b0-8500-893844077053&at=ABswASaMRVC8MmHEDfi76kUJZSnc:1784959033612

=== Track _ 07
https://drive.usercontent.google.com/download?id=14KaJWTjy0m68Mr_q8fxTBsWLuy-NSQfN&export=download&authuser=0&confirm=t&uuid=cd733dff-8f27-4c63-bc95-15e2f9df2295&at=ABswASZH3kuGPcIjY2623i9kIWor:1784959063342

=== Track _ 08
https://drive.usercontent.google.com/download?id=1LS1-8INR13aIlpUqOIBjdb_1ja7_ZeKk&export=download&authuser=0&confirm=t&uuid=d8b00ba8-af91-44cb-abcf-013d5a18afcd&at=ABswASbYgMd5shlyL8A4D7mxB5oC:1784959097304


=== Track _ 09
https://drive.usercontent.google.com/download?id=1aq-V79Lq-gQiJ3YtGPOxf-_eSSxN1XRc&export=download&authuser=0&confirm=t&uuid=1b5ada4f-c4b9-4eb2-be92-3cb76605213d&at=ABswASbMSBStsoAnDZDR4XGOQ-x0:1784959141374

=== Track _ 10
https://drive.usercontent.google.com/download?id=1XU8atPBoSWv3xRxnPFESwOxL-8Jlxfb3&export=download&authuser=0&confirm=t&uuid=51d02d04-5ae8-4ef5-a4ec-b2ea0c69773f&at=ABswASbZGTNE8vitzyl09xoQPZow:1784959277548

=== Track _ 11
https://drive.usercontent.google.com/download?id=10nD22X2137QbdjNVqqXFy-2HtdhPB96b&export=download&authuser=0&confirm=t&uuid=84ab9c99-5ed4-481b-97d0-aebff18bced3&at=ABswASbTbZnexoqWj6I2YD2dmJqo:1784959284750

=== Track _ 12
https://drive.usercontent.google.com/download?id=1Fa5fKXaIwPK4HZP_I9XvOFzHKyLv1FqO&export=download&authuser=0&confirm=t&uuid=04783ac5-48a1-4fa6-bd28-0bc8f4eec5ab&at=ABswASbYXW2jpmaSKRweYujSD27p:1784959293613

=== Track _ 13
https://drive.usercontent.google.com/download?id=1FJXvuwGUHDGuTp0kVHOZDoc8tJC4SrpB&export=download&authuser=0&confirm=t&uuid=a3ff8107-76cd-407d-8714-0baf99ece7ea&at=ABswASYB3S2Ik_O7poMFAlKfi21S:1784959304878

=== Track _ 14
https://drive.usercontent.google.com/download?id=1IaDmOs3gfgo_Mxam-KT1cQjJPvFD8Ri5&export=download&authuser=0&confirm=t&uuid=19540fb5-ac8f-4ac7-b779-f2dec00b9dcf&at=ABswASZMKZXghRfXgvOC3n7OG88g:1784960820274
