import sys
from PyQt5.QtWidgets import QApplication, QLabel, QMainWindow
from PyQt5.QtGui import QPixmap
from PyQt5.QtCore import Qt

class TransparentOverlay(QMainWindow):
    def __init__(self, image_path):
        super().__init__()
        self.setWindowFlags(Qt.FramelessWindowHint | Qt.WindowStaysOnTopHint | Qt.X11BypassWindowManagerHint)
        self.setAttribute(Qt.WA_TranslucentBackground)  # Make window background transparent
        self.setAttribute(Qt.WA_TransparentForMouseEvents)  # Allow mouse events to pass through

        self.image_path = image_path
        self.initUI()

    def initUI(self):
        label = QLabel(self)
        pixmap = QPixmap(self.image_path)

        self.setFixedSize(pixmap.size())  # Set the window size to match the image size
        label.setPixmap(pixmap)
        label.resize(pixmap.size())

        # Move window to the top left corner of the screen
        self.move(0, 0)

        self.show()

def handle_exit():
    print("Exiting gracefully...")
    QApplication.quit()

if __name__ == '__main__':
    app = QApplication(sys.argv)
    overlay = TransparentOverlay("cover1.png")  # Provide the path to your image
    app.aboutToQuit.connect(handle_exit)
    sys.exit(app.exec_())
