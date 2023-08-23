var levelUpModal = document.getElementById("level-up-modal");

if (levelUpModal !== null) {
  let currentConversationIndex = 0;
  let conversations;

  // showModal()メソッドの直後でデータを取得
  levelUpModal.showModal();
  fetch(`/conversations`)
      .then(response => response.json())
      .then(data => {
        conversations = data.conversations;
        document.getElementById("conversation-content").textContent = conversations[currentConversationIndex].content;
      });

  document.getElementById("next-button").addEventListener("click", function() {
    currentConversationIndex++;
    if (currentConversationIndex < conversations.length) {
      document.getElementById("conversation-content").textContent = conversations[currentConversationIndex].content;
    } else {
      closeModal();
    }
  });

  function closeModal() {
    levelUpModal.close();
  }
}