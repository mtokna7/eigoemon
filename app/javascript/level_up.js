var levelUpModal = document.getElementById("level-up-modal");
let currentConversationIndex = 0;
let conversations;
let speakers;

// showModal()メソッドの直後でデータを取得
levelUpModal.showModal();
fetch(`/api/v1/conversations`)
    .then(response => response.json())
    .then(data => {
      conversations = data.conversations;
      speakers = data.speakers; 
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