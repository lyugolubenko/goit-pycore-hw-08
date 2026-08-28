# 1. Базовий образ Python (використовуємо стабільний та легкий slim-образ)
FROM python:3.10-slim

# 2. Встановлюємо робочу директорію всередині контейнера
WORKDIR /app

# 3. Встановлюємо Poetry
RUN pip install --no-cache-dir poetry

# 4. Вимикаємо створення віртуального середовища Poetry всередині контейнера,
# щоб пакети встановлювалися прямо в системний Python контейнера
RUN poetry config virtualenvs.create false

# 5. Копіюємо конфігураційні файли залежностей
COPY pyproject.toml poetry.lock* /app/

# 6. Встановлюємо залежності проєкту без dev-пакетів
RUN poetry install --no-root --no-interaction --no-ansi

# 7. Копіюємо весь код проєкту у контейнер
COPY . /app

# 8. Команда за замовчуванням для запуску "Персонального помічника"
CMD ["python", "main.py"]