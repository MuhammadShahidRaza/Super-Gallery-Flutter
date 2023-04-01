import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:video_player/video_player.dart';

import '../models/selectionmodel.dart';

class Pictures_Screen extends StatefulWidget {
  const Pictures_Screen({Key? key}) : super(key: key);

  @override
  State<Pictures_Screen> createState() => _Pictures_ScreenState();
}

class _Pictures_ScreenState extends State<Pictures_Screen> {
  List<Album>? _albums;
  List<Album>? _videoalbums;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loading = true;
    initAsync();
  }

  Future<void> initAsync() async {
    if (await _promptPermissionSetting()) {
      List<Album> albums =
          await PhotoGallery.listAlbums(mediumType: MediumType.image);
      // List<Album> videoalbums =
      //     await PhotoGallery.listAlbums(mediumType: MediumType.video);
      setState(() {
        _albums = albums;

        _loading = false;
      });
    }
    setState(() {
      _loading = false;
    });
  }

  Future<bool> _promptPermissionSetting() async {
    if (Platform.isIOS &&
            await Permission.storage.request().isGranted &&
            await Permission.photos.request().isGranted ||
        Platform.isAndroid && await Permission.storage.request().isGranted) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : LayoutBuilder(
            builder: (context, constraints) {
              double gridWidth = (constraints.maxWidth - 20) / 3;
              double gridHeight = gridWidth + 33;
              double ratio = gridWidth / gridHeight;
              return Container(
                padding: EdgeInsets.all(5),
                child: GridView.count(
                  childAspectRatio: ratio,
                  crossAxisCount: 3,
                  mainAxisSpacing: 5.0,
                  crossAxisSpacing: 5.0,
                  children: <Widget>[
                    ...?_albums?.map(
                      (album) => GestureDetector(
                        onTap: (){


                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AlbumPage(album)));},
                        child: Column(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(5.0),
                              child: Container(
                                color: Colors.grey[300],
                                height: gridWidth,
                                width: gridWidth,
                                child: FadeInImage(
                                  fit: BoxFit.cover,
                                  placeholder: MemoryImage(kTransparentImage),
                                  image: AlbumThumbnailProvider(
                                    albumId: album.id,
                                    mediumType: album.mediumType,
                                    highQuality: true,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 2.0),
                              child: Text(
                                album.name ?? "Unnamed Album",
                                maxLines: 1,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  height: 1.2,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 2.0),
                              child: Text(
                                album.count.toString(),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  height: 1.2,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
  }
}

class AlbumPage extends StatefulWidget {
  final Album album;

  AlbumPage(Album album) : album = album;

  @override
  State<StatefulWidget> createState() => AlbumPageState();
}

class AlbumPageState extends State<AlbumPage> {
  List<Medium>? _media;
    List<selectionmodel> mediaid=[];

  @override
  void initState() {
    super.initState();
    initAsync();
  }

  void initAsync() async {
    MediaPage mediaPage = await widget.album.listMedia();
    setState(() {
      _media = mediaPage.items;
    });
  }
  uploadImage() async {
    int index=0;
   var user= FirebaseAuth.instance.currentUser;
    List<String> urllist= [];
    try {
      EasyLoading.show();
      final _firebaseStorage = FirebaseStorage.instance;

      for (int i = 0; i < mediaid.length; i++) {
        var snapshot = await _firebaseStorage
            .ref()
            .child(
            'images/${user?.uid}/${mediaid[i].file!.path.replaceAll('.', '')
                .replaceAll('/', '')}')
            .putFile(mediaid[i].file!);
        var downloadUrl = await snapshot.ref.getDownloadURL();
        urllist.add(downloadUrl);
      }

      await FirebaseDatabase.instance.ref().child('users').child(user!.uid)
          .child('images').push().update({'images':urllist})
          .then((value) {});
      EasyLoading.showToast('successfully !!');
    }     catch(e){}finally{
      EasyLoading.dismiss();
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Row(
            children: [
              Text(widget.album.name ?? "Unnamed Album"),
              Spacer(),
              if(mediaid.length>0)
              GestureDetector(
                  onTap: () async {
                 await uploadImage();
                  },
                  child: Text("Done")),
            ],
          ),
        ),
        body: GridView.count(
          crossAxisCount: 3,
          mainAxisSpacing: 1.0,
          crossAxisSpacing: 1.0,
          children: <Widget>[

            ...?_media?.map(
              (medium) => GestureDetector(
                onTap: () async { bool item=false;
                for(int i=0;i<mediaid.length;i++) {
                  if(mediaid[i].id==medium.id)
                    item = mediaid.remove(mediaid[i]);
                }


                  if(mediaid.length>0&&item==false) {
                   File f=await medium.getFile();
                    mediaid.add(new selectionmodel(id: medium.id, file:f));
                  }
                      setState(() {

                      });
                  //
                  // Navigator.of(context).push(MaterialPageRoute(
                  //   builder: (context) => ViewerPage(medium)
                  // )

                //);
              },
                onLongPress: () async {
                  bool item=false;
                  for(int i=0;i<mediaid.length;i++) {
                    if(mediaid[i].id==medium.id)
                    item = mediaid.remove(mediaid[i]);
                  }
                         if(!item) {
                           File f=await medium.getFile();
                           print(f);
                           mediaid.add(new selectionmodel(id: medium.id, file:f));
                  }

                  setState(() {


                 });
                },
                child: Container(
               //   color: Colors.grey[300],
                  child: Stack(
                    alignment: Alignment.center,
                    children: [

                      FadeInImage(
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill,
                        placeholder: MemoryImage(kTransparentImage),
                        image: ThumbnailProvider(
                          mediumId: medium.id,
                          mediumType: medium.mediumType,
                          highQuality: true,
                        ),
                      ),
                       Positioned(
                         top: 15,
                         child: Container(
                              width: 30,height: 60,

                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: mediaid.length,
                                itemBuilder: (context,index) {
                                  return(mediaid[index].id==medium.id)? Container(
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(100)
                                    ),
                                   width: 30,height: 30,
                                  child: Icon(Icons.check,color: Colors.white,),
                                  )
                                  :Container()
                                  ;
                                }
                              ),
                            ),
                       ),

                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      );

  }
}

class ViewerPage extends StatelessWidget {
  final Medium medium;

  ViewerPage(Medium medium) : medium = medium;

  @override
  Widget build(BuildContext context) {
    DateTime? date = medium.creationDate ?? medium.modifiedDate;
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back_ios),
          ),
          title: date != null ? Text(date.toLocal().toString()) : null,
        ),
        body: Container(
          alignment: Alignment.center,
          child: medium.mediumType == MediumType.image
              ? FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: MemoryImage(kTransparentImage),
                  image: PhotoProvider(mediumId: medium.id),
                )
              : VideoProvider(
                  mediumId: medium.id,
                ),
        ),
      ),
    );
  }
}

class VideoProvider extends StatefulWidget {
  final String mediumId;

  const VideoProvider({
    required this.mediumId,
  });

  @override
  _VideoProviderState createState() => _VideoProviderState();
}

class _VideoProviderState extends State<VideoProvider> {
  VideoPlayerController? _controller;
  File? _file;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initAsync();
    });
    super.initState();
  }

  Future<void> initAsync() async {
    try {
      _file = await PhotoGallery.getFile(mediumId: widget.mediumId);
      _controller = VideoPlayerController.file(_file!);
      _controller?.initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    } catch (e) {
      print("Failed : $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return _controller == null || !_controller!.value.isInitialized
        ? Container()
        : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              AspectRatio(
                aspectRatio: _controller!.value.aspectRatio,
                child: VideoPlayer(_controller!),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _controller!.value.isPlaying
                        ? _controller!.pause()
                        : _controller!.play();
                  });
                },
                child: Icon(
                  _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
                ),
              ),
            ],
          );
  }
}
