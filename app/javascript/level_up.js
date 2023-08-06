var levelUpModal = document.getElementById("level-up-modal");
levelUpModal.showModal();

let currentConversationIndex = 0;
const conversations = window.conversationsData;
const speakers = window.speakersData;

// ここで初期の会話文を設定
document.getElementById("conversation-content").textContent = conversations[currentConversationIndex];

document.getElementById("next-button").addEventListener("click", function() {
  currentConversationIndex++;
  if (currentConversationIndex < conversations.length) {
    document.getElementById("conversation-content").textContent = conversations[currentConversationIndex];
    // ここで、speakerに応じて表示を変更することも可能です。
  } else {
    closeModal();
  }
});



function closeModal() {
  levelUpModal.close();
  fetch("/users/" + window.currentUser.id, {
    method: "PATCH",
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-Token": window.currentUser.token,
      "Accept": "application/json"
    },
    body: JSON.stringify({
      user: { leveled_up: false }
    })
  });
}