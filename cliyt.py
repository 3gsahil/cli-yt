import sys
from PyQt5.QtWidgets import QApplication, QWidget, QLabel, QLineEdit, QPushButton, QComboBox
from subprocess import call

class App(QWidget):

    def __init__(self):
        super().__init__()
        self.title = 'YouTube Player'
        self.left = 100
        self.top = 100
        self.width = 400
        self.height = 200
        self.initUI()

    def initUI(self):
        self.setWindowTitle(self.title)
        self.setGeometry(self.left, self.top, self.width, self.height)

        # Video URL input field
        self.url_label = QLabel('Video URL:', self)
        self.url_label.move(20, 20)
        self.url_field = QLineEdit(self)
        self.url_field.move(100, 20)
        self.url_field.resize(280, 20)

        # Play/Download selection dropdown
        self.action_label = QLabel('Select Action:', self)
        self.action_label.move(20, 60)
        self.action_dropdown = QComboBox(self)
        self.action_dropdown.addItem('Play')
        self.action_dropdown.addItem('Download')
        self.action_dropdown.move(100, 60)

        # Submit button
        self.submit_button = QPushButton('Submit', self)
        self.submit_button.move(150, 100)
        self.submit_button.clicked.connect(self.on_submit)

        self.show()

    def on_submit(self):
        url = self.url_field.text()
        action = self.action_dropdown.currentText()

        # Extract the video ID from the URL
        video_id = url.split('v=')[1]

        if action == 'Play':
            # Play the video using mpv
            call(['mpv', f'https://www.youtube.com/watch?v={video_id}'])
        elif action == 'Download':
            # Download the video using yt-dlp
            call(['yt-dlp', '-o', '%(title)s.%(ext)s', f'https://www.youtube.com/watch?v={video_id}'])

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = App()
    sys.exit(app.exec_())
