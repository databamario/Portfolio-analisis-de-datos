#!/usr/bin/env python
# coding: utf-8

# In[1]:


from bs4 import BeautifulSoup
import requests
import smtplib
import time 
import datetime
import pandas as pd


# In[2]:


import requests
from bs4 import BeautifulSoup
import csv

# Tu código para realizar la solicitud HTTP y analizar la página con BeautifulSoup
URL = 'https://www.amazon.es/kindle-2022/dp/B09SWTJZH6/ref=sr_1_1?__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=3FSWNYRE6VTRD&keywords=kindle&qid=1702487979&sprefix=kindle%2Caps%2C111&sr=8-1&th=1'
headers = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36",
    "Accept-Encoding": "gzip, deflate",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "DNT": "1",
    "Connection": "close",
    "Upgrade-Insecure-Requests": "1"
}
page = requests.get(URL, headers=headers)
soup = BeautifulSoup(page.content, "html.parser")

# Buscar el título del producto
title = soup.find(id='productTitle').get_text(strip=True)

# Buscar el precio del producto
price_element = soup.find('span', {'class': 'a-price'})
price = price_element.find('span', {'class': 'a-offscreen'}).get_text(strip=True) if price_element else "No disponible"

data = {'Producto': [title], 'Precio': [price]}
df = pd.DataFrame(data)
print(df)
 


# In[3]:


import datetime

today = datetime.date.today()

print(today)


# In[4]:


import csv
import pandas as pd

# Supongamos que price es un número
price = 109.00

# Formatea el precio como una cadena con coma para los decimales
formatted_price = f'{price:.2f}€'

# Resto del código
header = ['Producto', 'Precio', 'Fecha']

# Asegúrate de que formatted_price y today sean cadenas
data = [title, str(formatted_price), str(today)]

# Escribe los datos en un archivo CSV
with open('AmazonKindleScraper.csv', 'w', newline='', encoding='utf-8-sig') as f:
    writer = csv.writer(f, delimiter=';')
    writer.writerow(header)
    writer.writerow(data)

# Lee el archivo CSV con pandas para verificar los datos
df = pd.read_csv(r'C:\Users\mario\AmazonKindleScraper.csv', delimiter=';', quotechar='"', escapechar='\\')
print(df)


# In[5]:


import pandas as pd

# Lee el archivo CSV con configuración específica
df = pd.read_csv(r'C:\Users\mario\AmazonKindleScraper.csv', delimiter=';', quotechar='"', escapechar='\\')

print(df)


# In[6]:


with open('AmazonKindleScraper.csv', 'a+', newline='', encoding='utf-8-sig') as f:
    writer = csv.writer(f, delimiter=';', quotechar='"', escapechar='\\')
    writer.writerow(data)


# In[7]:


def check_price():
    URL = 'https://www.amazon.es/kindle-2022/dp/B09SWTJZH6/ref=sr_1_1?__mk_es_ES=%C3%85M%C3%85%C5%BD%C3%95%C3%91&crid=3FSWNYRE6VTRD&keywords=kindle&qid=1702487979&sprefix=kindle%2Caps%2C111&sr=8-1&th=1'
    
    headers = {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36",
        "Accept-Encoding": "gzip, deflate",
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "DNT": "1",
        "Connection": "close",
        "Upgrade-Insecure-Requests": "1"
    }

    page = requests.get(URL, headers=headers)

    soup = BeautifulSoup(page.content, "html.parser")

    title = soup.find(id='productTitle').get_text(strip=True)

    price_element = soup.find('span', {'class': 'a-price'})

    price = price_element.find('span', {'class': 'a-offscreen'}).get_text(strip=True) if price_element else "No disponible"

    import datetime

    today = datetime.date.today()

    print(today)

    import csv

    price = 109.00

    formatted_price = f'{price:.2f}€'

    header = ['Producto', 'Precio', 'Fecha']

    data = [title, str(formatted_price), str(today)]
    
    with open('AmazonKindleScraper.csv', 'a+', newline='', encoding='utf-8-sig') as f:
        writer = csv.writer(f, delimiter=';', quotechar='"', escapechar='\\')
        writer.writerow(data)
    
    if float(price) < 80:
        send_mail()



# In[8]:


def send_mail():
    server = smtplib.SMTP_SSL('smtp.gmail.com', 465)
    server.ehlo()
    server.login('email_del_emisor@gmail.com', '**** **** **** ****')

    subject = "El kindle ha sido rebajado a 80€"
    body = "Es el momento de realizar la compra que tanto tiempo has deseado, está a un precio increíble"

    msg = f"Subject: {subject}\n\n{body}"

    server.sendmail('email_del_emisor@gmail.com', 'email_del_receptor@gmail.com', msg.encode('utf-8'))


# In[ ]:


while True:
    check_price()
    time.sleep(86400)


# In[ ]:


import pandas as pd

# Lee el archivo CSV con configuración específica
df = pd.read_csv(r'C:\Users\mario\AmazonKindleScraper.csv', delimiter=';', quotechar='"', escapechar='\\')

print(df)


# In[ ]:





# In[ ]:




