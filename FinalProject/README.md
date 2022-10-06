1. Вы создали не менее 2х машин в вашей инфраструктуре, и они доступны
из внешнего интернета (AWS/AZURE). - Done
2. У вас есть контейнер, который запускает одну из систем для
автоматизации CI/CD Jenkins/Teamcity. Not Done(deployment from container require further investigation)
3. У вас есть CI/CD pipeline на Jenkins/Teamcity, которая позволяет вам
поднять контейнер docker, выполнить shellscript который может поднять
Azure/AWS VM. - Done
4. База данных SQL или NoSQL, развернутая на VM и наполненная
любыми тестовыми данными. - Done
5. У вас настроена система сбора метрик и мониторинга Grafana и
настроены правила для сбора информации о CPU/RAM/Disk, хотя бы
одной из ваших машин. - Not Done(deployment from container require further investigation)
