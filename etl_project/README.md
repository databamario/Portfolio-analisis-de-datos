# 🚀 Pipeline ETL - CoinMarketCap API

[![Python](https://img.shields.io/badge/Python-3.11+-blue.svg)](https://www.python.org/)
[![SQLite](https://img.shields.io/badge/Database-SQLite-green.svg)](https://www.sqlite.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 📋 Descripción

Pipeline ETL completo que extrae datos del mercado de criptomonedas desde CoinMarketCap API, los transforma con pandas y los almacena en SQLite para análisis avanzados.

**Proyecto desarrollado para portfolio profesional de Ingeniería de Datos**

---

## ✨ Características Principales

- ✅ **ETL Robusto**: Extracción con reintentos automáticos y rate limiting
- ✅ **Transformación**: Normalización de JSON anidado a tablas relacionales
- ✅ **Base de datos**: 13 tablas en SQLite (3 operacionales + 10 analíticas)
- ✅ **Análisis Avanzado**: Time-series, alertas, portfolio tracking, correlaciones
- ✅ **Scoring ML**: Sistema de clasificación de inversiones
- ✅ **Automatización**: Ejecución programada cada N horas

---

## 🏗️ Arquitectura

```
┌─────────────┐      ┌──────────────┐      ┌─────────────────┐
│   EXTRACT   │ ───> │  TRANSFORM   │ ───> │      LOAD       │
│ CoinMktCap  │      │    pandas    │      │     SQLite      │
│     API     │      │ Normalizar   │      │   13 tablas     │
└─────────────┘      └──────────────┘      └─────────────────┘
                                                     │
                                                     ▼
                                            ┌─────────────────┐
                                            │    ANÁLISIS     │
                                            │ • Segmentación  │
                                            │ • Time-series   │
                                            │ • Alertas       │
                                            │ • Portfolio     │
                                            │ • Correlaciones │
                                            │ • ML Scoring    │
                                            └─────────────────┘
```

---

## 📊 Tablas Generadas

### **Operacionales (3)**
1. `crypto_listings` - Top 100 criptomonedas con precios y métricas
2. `global_metrics` - Métricas agregadas del mercado
3. `crypto_metadata` - Información detallada (URLs, logos, categorías)

### **Analíticas (10)**
4. `crypto_analytics` - Métricas derivadas y clasificaciones
5. `crypto_history` - Snapshots históricos para time-series
6. `price_alerts` - Sistema de alertas por volatilidad
7. `my_portfolio` - Tracking de portfolio personal
8. Y más tablas de análisis especializadas

---

## 🛠️ Stack Técnico

| Categoría | Tecnologías |
|-----------|------------|
| **Lenguaje** | Python 3.11+ |
| **ETL** | pandas, requests |
| **Base de datos** | SQLite3 |
| **Análisis** | SQL avanzado (CTEs, window functions) |
| **Automatización** | schedule |
| **Entorno** | Jupyter Notebook |

---

## 📁 Estructura del Proyecto

```
ETL_cmc/
│
├── ETL_CoinMarketCap_Portfolio.ipynb  # Pipeline ETL principal
├── Analisis_ETL_cmc.ipynb             # Análisis avanzados
├── .env                                # Credenciales API (no incluido)
├── coinmarketcap_etl.db               # Base de datos SQLite
├── ETL/                                # Entorno virtual Python
└── README.md                           # Este archivo
```

---

## 🚀 Cómo Ejecutar

### **1. Requisitos previos**

```bash
# Python 3.11+
python --version

# Instalar dependencias
pip install requests pandas python-dotenv schedule
```

### **2. Configuración**

Crea un archivo `.env` en la raíz del proyecto:

```env
CMC_API_KEY=tu_api_key_aqui
```

> 💡 Obtén tu API key gratis en [CoinMarketCap](https://coinmarketcap.com/api/)

### **3. Ejecución**

**Opción A - Completo (recomendado para primera vez):**
```
1. Abrir ETL_CoinMarketCap_Portfolio.ipynb
2. Ejecutar "Run All"
```

**Opción B - Manual:**
```
1. Ejecutar celdas 1-6 (definiciones)
2. Ejecutar celda 7 para actualizar datos
3. Ejecutar celdas 8-9 para verificación
```

**Opción C - Automatizado:**
```
1. Descomentar última línea de celda 10
2. El ETL se ejecutará cada 12 horas automáticamente
```

### **4. Análisis Avanzado**

```
1. Asegurar que coinmarketcap_etl.db existe
2. Abrir Analisis_ETL_cmc.ipynb
3. Ejecutar las celdas deseadas
```

---

## 📈 Análisis Implementados

| # | Análisis | Descripción |
|---|----------|-------------|
| 1 | **Top Movers** | Mayores ganadores/perdedores 24h |
| 2 | **Segmentación** | Análisis por market cap categories |
| 3 | **Ratios** | Volume/MarketCap, momentum, liquidez |
| 4 | **Dominancia** | % de dominancia sobre mercado total |
| 5 | **Time-Series** | Tracking histórico de precios |
| 6 | **Alertas** | Sistema automático por volatilidad |
| 7 | **Portfolio** | Tracking con cálculo de ROI |
| 8 | **Categorías** | Rendimiento por sectores crypto |
| 9 | **Correlación** | Matriz de correlación entre assets |
| 10 | **Indicadores** | RSI, momentum, tendencias |
| 11 | **ML Scoring** | Clasificación de inversiones |

---

## 🔑 Endpoints Utilizados

### **Free Tier (implementados)**
- `/v1/cryptocurrency/listings/latest` - Top 100 cryptos
- `/v1/global-metrics/quotes/latest` - Métricas globales
- `/v1/cryptocurrency/info` - Metadata detallada
- `/v1/key/info` - Verificación de créditos

### **Premium (documentados, no implementados)**
- `/v1/cryptocurrency/trending/gainers-losers`
- `/v1/cryptocurrency/ohlcv/historical`
- `/v2/cryptocurrency/quotes/historical`

> ℹ️ El plan gratuito (10k créditos/mes) es suficiente para este proyecto

---

## 📊 Resultados

- ✅ Base de datos operacional con 13 tablas
- ✅ Sistema de alertas funcional
- ✅ Portfolio tracking con ROI calculado
- ✅ Sistema de scoring para clasificación
- ✅ Pipeline automatizable

**Consumo estimado:** ~3-5 créditos por ejecución completa

---

## 🚀 Expansiones Futuras

1. **Visualización**: Dashboards con Plotly/Streamlit
2. **ML Avanzado**: Modelos predictivos (LSTM, Prophet)
3. **APIs Premium**: Datos históricos OHLCV
4. **Alertas Real-time**: Webhooks/Telegram
5. **Cloud Deploy**: AWS/Azure para producción

---

## 📝 Notas Importantes

⚠️ **Disclaimer**: Proyecto educativo y de demostración técnica. No constituye asesoramiento financiero.

📄 **Licencia**: MIT - Libre para uso educativo y profesional.

---

## 👨‍💻 Autor

**Mario Soriano Bañuls**

Portfolio profesional | Octubre 2025



