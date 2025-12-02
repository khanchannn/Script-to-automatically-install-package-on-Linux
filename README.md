# 🚀 Ubuntu Server Setup Script

Script Bash "All-in-one" giúp tự động hóa việc thiết lập môi trường ban đầu cho một Ubuntu VPS hoặc Virtual Machine mới. Tiết kiệm thời gian cài đặt thủ công và đảm bảo các tiêu chuẩn bảo mật cơ bản.

## 📦 Script này cài đặt những gì?

* **System Utilities (Bộ công cụ cơ bản):**
    * `curl`, `wget`, `git` (để tải và quản lý source code).
    * `vim`, `nano` (trình chỉnh sửa văn bản).
    * `htop`, `unzip`, `net-tools` (quản lý tài nguyên và mạng).
* **Security (Bảo mật):**
    * `ufw`: Cấu hình tường lửa (tự động mở port SSH để tránh bị lock out).
    * `fail2ban`: Tự động chặn IP khi phát hiện tấn công brute-force.
* **Web & Containers (Môi trường chạy ứng dụng):**
    * `nginx`: Web server và Reverse proxy hiệu năng cao.
    * `docker` & `docker-compose`: Môi trường container hóa tiêu chuẩn.

## 🛠️ Hướng dẫn sử dụng

1.  **Tạo file script:**
    ```bash
    nano setup_server.sh
    ```
    *(Dán nội dung script vào và lưu file lại)*

2.  **Cấp quyền thực thi:**
    ```bash
    chmod +x setup_server.sh
    ```

3.  **Chạy script (với quyền sudo):**
    ```bash
    sudo ./setup_server.sh
    ```

---
**Lưu ý:** Script này được tối ưu hóa cho **Ubuntu** (khuyên dùng phiên bản 20.04 LTS trở lên).
