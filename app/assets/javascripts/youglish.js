var tag = document.createElement('script');
tag.src = "https://youglish.com/public/emb/widget.js";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);

var widget;
function onYouglishAPIReady(){
  widget = new YG.Widget("youglish-widget", {
    width: 400,
    components:11, //検索・字幕・アクセント選択
    autoStart: 1, // 自動再生on
    restrictionMode: 1, // キッズモードon
    events: {
      'onFetchDone': onFetchDone,
      'onVideoChange': onVideoChange,
    }          
  });

  var word = document.getElementById('youglish-widget').dataset.word;
  widget.fetch(word, "english", "us"); // デフォルトをusアクセントに設定
}

// コントローラに動画の自動切り替えを追加するなら必要
var curTrack = 0, totalTracks = 0;

function onFetchDone(event){
  if (event.totalResult === 0)   alert("No result found");
  else totalTracks = event.totalResult; 
}

function onVideoChange(event){
  curTrack = event.trackNumber;
}

// コントローラの機能
document.getElementById('play-button').addEventListener('click', function() {
  widget.play();
});

document.getElementById('pause-button').addEventListener('click', function() {
  widget.pause();
});

document.getElementById('repeat-button').addEventListener('click', function() {
  widget.replay();
});

document.getElementById('next-button').addEventListener('click', function() {
  widget.next();
});

document.getElementById('prev-button').addEventListener('click', function() {
  widget.previous();
});