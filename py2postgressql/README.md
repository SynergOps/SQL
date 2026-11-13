# Python to PostgreSQL

A minimal educational example showing how to connect to a PostgreSQL database using Python, manage environment variables securely, and execute basic SQL commands.

---

## Getting Started

### 1. Clone the repository & enter the folder
```bash
cd py2postgresql
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
Open `.env` in your text editor and fill in your PostgreSQL connection details:
```env
DB_NAME=your_db_name
DB_USER=your_username
DB_PASSWORD=your_password
DB_HOST=your_host
DB_PORT=5432
```

### 5. Run the script
```bash
python main.py
```
