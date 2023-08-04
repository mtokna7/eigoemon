import consumer from "./consumer"

if (window.currentUserId) {
  consumer.subscriptions.create({ channel: "LevelUpChannel", user_id: window.currentUserId }, {
    received(data) {
      // モーダルの中身を作成
      document.getElementById('modalTitle').textContent = "レベルアップ！";
      document.getElementById('modalContent').textContent = `現在のレベルは${data.level}です。メールアドレス：${data.someValue}`;

      // 画像を表示
      document.getElementById('modalImage').classList.remove('hidden');

      // モーダルを表示
      const modal = document.getElementById('myModal');
      modal.showModal();
    }
  });
}
