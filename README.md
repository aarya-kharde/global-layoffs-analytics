# Tech Layoffs Analysis (2020–2023)

## 📌 Project Overview
This project analyzes global tech and startup layoffs between **March 2020 and March 2023** using SQL.  
The goal is to identify **trends, patterns, and risk signals** across companies, industries, countries, funding stages, and time.

The analysis focuses on:
- Companies with the highest layoffs
- Startups that shut down completely (100% layoffs)
- Industry and country-level impact
- Layoff trends over time (monthly, yearly, rolling totals)
- Relationship between funding stage and layoffs

---

## 🗂 Dataset Summary
- **Time range:** March 11, 2020 → March 6, 2023  
- **Total layoffs analyzed:** ~383,000  
- **Scope:** Global (US, India, Europe, Asia, Australia, Africa)  
- **Company stages:** Seed to Post-IPO  

---

## 🔍 Key Insights

### 1️⃣ Maximum Layoffs
- **Largest single layoff event:**  
  - **Google – 12,000 employees**
- **Maximum percentage laid off:**  
  - **100% layoffs**, indicating full company shutdowns

---

### 2️⃣ Companies With 100% Layoffs
These companies laid off their **entire workforce**, often signaling business failure or shutdown.

**Notable examples:**
- **Katerra (Construction)** – 2,434 employees  
- **Butler Hospitality (Food)** – 1,000  
- **Deliv (Retail)** – 669  
- **Britishvolt (Transportation)** – 206  

**Insight:**  
Several companies that shut down completely had raised large amounts of capital, showing that **funding alone does not guarantee long-term survival**.

---

### 3️⃣ Heavily Funded Companies That Still Collapsed
Some startups raised **hundreds of millions or billions** yet still experienced 100% layoffs:

| Company | Funding Raised ($M) | Industry |
|------|------|------|
| Britishvolt | 2,400 | Transportation |
| Quibi | 1,800 | Media |
| Deliveroo Australia | 1,700 | Food |
| Katerra | 1,600 | Construction |
| BlockFi | 1,000 | Crypto |

**Insight:**  
Over-expansion, poor unit economics, and market downturns can outweigh high funding levels.

---

### 4️⃣ Companies With the Highest Total Layoffs
Top contributors to overall job losses:

1. **Amazon** – 18,150  
2. **Google** – 12,000  
3. **Meta** – 11,000  
4. **Salesforce** – 10,090  
5. **Microsoft** – 10,000  

**Insight:**  
Layoffs were not limited to startups — **large, mature tech companies were major contributors**, especially after 2022.

---

### 5️⃣ Industry Impact
Industries most affected by layoffs:

| Industry | Total Layoffs |
|-------|---------------|
| Consumer | 45,182 |
| Retail | 43,613 |
| Transportation | 33,748 |
| Finance | 28,344 |
| Healthcare | 25,953 |
| Food | 22,855 |
| Real Estate | 17,565 |

**Insight:**  
Industries tied to **consumer demand, logistics, and capital-intensive operations** were hit hardest during economic slowdowns.

---

### 6️⃣ Country-Level Impact
Countries with the highest number of layoffs:

| Country | Total Layoffs |
|------|---------------|
| United States | 256,559 |
| India | 35,993 |
| Netherlands | 17,220 |
| Sweden | 11,264 |
| Brazil | 10,391 |

**Insight:**  
The United States dominates layoffs due to its large tech workforce, while India reflects vulnerability in venture-backed startups.

---

### 7️⃣ Layoffs Over Time
**Yearly breakdown:**
- **2020:** 80,998 (COVID-19 impact)
- **2021:** 15,823 (recovery period)
- **2022:** 160,661 (market correction)
- **2023 (Q1):** 125,677 (Big Tech restructuring)

- **Peak month:** January 2023 – 84,714 layoffs  
- **Rolling total by March 2023:** 383,159 layoffs  

**Insight:**  
Layoffs occurred in two major waves:
1. Initial COVID-19 shock  
2. Post-pandemic correction driven by rising interest rates and over-hiring

---

### 8️⃣ Funding Stage Analysis
Layoffs by company stage:

| Stage | Total Layoffs |
|------|---------------|
| Post-IPO | 204,132 |
| Unknown | 40,716 |
| Acquired | 27,576 |
| Series C–E | ~47,000 combined |
| Seed | 1,636 |

**Insight:**  
Most layoffs came from **Post-IPO companies**, indicating pressure from public markets and profitability expectations.

---

## 📌 Key Takeaways
- Layoffs are **cyclical** and closely tied to macroeconomic conditions.
- High funding does **not** guarantee company stability.
- Post-IPO companies experienced the **largest workforce reductions**.
- Consumer-focused and capital-intensive industries are most vulnerable.
- The 2022–2023 layoffs represent a correction after aggressive hiring in 2020–2021.

---

## 🛠 Tools Used
- **SQL (MySQL)**
- Common Table Expressions (CTEs)
- Window functions
- Aggregations and time-series analysis

---

## 📈 Future Improvements
- Add visualizations (Tableau / Power BI)
- Analyze layoffs relative to funding size
- Compare early-stage vs late-stage company survival
- Industry-level trend forecasting
