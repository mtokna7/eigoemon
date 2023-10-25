// SpeechRecognitionオブジェクトを作成
const recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();

// 認識言語をアメリカ英語に設定
recognition.lang = 'en-US';

// 音声認識が一度終了したら自動的に停止
recognition.continuous = false;

// 認識結果を取得するためのイベントリスナーを設定
recognition.addEventListener('result', (event) => {
  const transcriptElement = document.getElementById('transcript');
  const transcript = Array.from(event.results)
    .map(result => result[0])
    .map(result => result.transcript)
    .join('');

  const confidence = Array.from(event.results)
    .map(result => result[0])
    .map(result => result.confidence)
    .reduce((a, b) => a + b, 0) / event.results.length; // 平均信頼度を計算

  if (transcript === '' || confidence < 0.4) { // 信頼度のしきい値を0.4に調整
    transcriptElement.innerText = '認識できませんでした';
    transcriptElement.classList.add('text-xl', 'font-yusei');
  } else {
    console.log(transcript); // ここで認識結果を表示
    transcriptElement.innerText = transcript; // 認識結果を表示エリアに表示
    transcriptElement.classList.add('text-xl', 'font-yusei');
  }
});

// 音声認識が開始されたときのイベントリスナー
recognition.addEventListener('start', () => {
  const statusElement = document.getElementById('status');
  document.getElementById('transcript').innerText = '';
  statusElement.innerHTML = '音声をにんしき中です<span class="loading loading-spinner text-green-500"></span>';
  statusElement.classList.add('text-xl', 'font-yusei'); 
});

// 音声認識が終了したときのイベントリスナー
recognition.addEventListener('end', () => {
  document.getElementById('status').innerText = '';
});

// 音声認識を開始する関数
function startRecognition() {
  recognition.start();
}

// グローバルスコープに関数を公開（HTMLからアクセスできるようにするため）
window.startRecognition = startRecognition;