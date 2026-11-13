# Python to MySQL

A minimal educational example showing how to connect to a MySQL database using Python, manage environment variables securely, and execute basic SQL commands.

---

## Getting Started

### 1. Enter the folder
```bash
cd py2mysql
```

### 2. Set up a virtual environment

- **macOS / Linux:**
  ```bash
  python3 -m venv .venv
  source .venv/bin/activate
  ```

- **Windows:**
  ```bash
  python -m venv .venv
  .venv\Scripts\activate
  ```

### 3. Install dependencies
```bash
pip install -r requirements.txt
```

### 4. Configure database credentials
Copy `.env.example` to create your own `.env` file:
```bash
cp .env.example .env
```
Open `.env` in your text editor and fill in your MySQL connection details:
```env
DB_NAME=your_db_name
DB_USER=your_username
DB_PASSWORD=your_password
DB_HOST=your_host
DB_PORT=3306
```

### 5. Run the script
```bash
python main.py
```

---

## MariaDB Compatibility

Because MariaDB is an open-source fork of MySQL, this project works with MariaDB out of the box:

- **Port & Credentials:** MariaDB uses the same default port (`3306`) and connection parameters.
- **SQL Syntax:** The table schema (`INT AUTO_INCREMENT PRIMARY KEY`), backtick quoting, data types (`CHAR(1)`, `VARCHAR`, `INT`), and queries are 100% compatible.
- **Python Connector:**
  - You can keep using `mysql-connector-python` (or `PyMySQL`) directly with MariaDB without code changes.
  - Alternatively, you can use the official `mariadb` package (`pip install mariadb`), which requires the native MariaDB Connector/C library (e.g. via `brew install mariadb-connector-c` on macOS).

