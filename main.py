from datetime import datetime
import os

from dotenv import load_dotenv
import vk_api


load_dotenv()

TOKEN = os.getenv("TOKEN")


def main():
    vk_session = vk_api.VkApi(token=TOKEN)
    vk = vk_session.get_api()

    friends = vk.friends.get(fields="last_seen")
    count = friends.get("count")

    print(f"Найдено друзей: {count}")

    limit_input = input("Введите дату (по умолчанию 01.01.2023): ")

    try:
        limit = datetime.strptime(limit_input, "%d.%m.%Y").timestamp()
    except ValueError:
        print("Ошибка ввода. Использую дату по умолчанию: 01.01.2023")
        limit = datetime.strptime("01.01.2023", "%d.%m.%Y").timestamp()

    filtered = []

    for item in friends.get("items"):
        last_seen = item.get("last_seen")

        if last_seen:
            if last_seen.get("time") < limit:
                filtered.append(item.get("id"))
        else:
            print(
                f"Время последнего входа закрыта: {item.get('first_name')} {item.get('last_name')}"
            )

    answer = input(f"Будет удалено {len(filtered)}. Вы уверены? (y/n): ")

    if answer == "y":
        print("Начинаю удаление...")
        for i in filtered:
            vk.friends.delete(user_id=i)

        print("Удаление завершено!")

        friends = vk.friends.get(fields="last_seen")

        print(f"Текущее количество друзей: {len(friends.get('items'))}")


if __name__ == "__main__":
    main()
