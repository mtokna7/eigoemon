import consumer from "./consumer"

if (window.currentUserId) {
  consumer.subscriptions.create({ channel: "LevelUpChannel", user_id: window.currentUserId }, {
    received(data) {
      // ここでモーダルを表示するコードを書く
      alert(`レベルアップ！現在のレベルは${data.level}です。`);
    }
  });
}
