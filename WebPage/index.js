window.addEventListener("DOMContentLoaded", () => {
  const releaseTagElement = document.getElementById("release-tag");

  fetch("https://github.com/3gsahil/ytcli/archive/refs/heads/main.zip")
    .then((response) => response.json())
    .then((data) => {
      const latestTag = data.tag_name;
      releaseTagElement.textContent = `${latestTag}`;
    })
    .catch((error) => {
      console.error("Decline Error:", error);
      releaseTagElement.textContent = "in mind version";
    });
});
