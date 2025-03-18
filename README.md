# Feature Extraction from .mat Files

## Overview
This MATLAB script processes multiple `.mat` files stored in a specified directory. It extracts key features such as **time**, **force**, **displacement**, and the **Tabor parameter (\mu)**. The script also applies data cleaning, interpolation, and normalization before saving the processed results.

## Features
- Reads multiple `.mat` files dynamically
- Extracts relevant variables: **time, force, displacement, Tabor parameter**
- Handles missing values and filters noisy data
- Interpolates data segments for consistency
- Saves results in **MATLAB (.mat) format** and **CSV format** for further analysis
- Generates **visual plots** for force, displacement, and time series

## Requirements
- MATLAB (Tested on R2021a and later)
- `.mat` files containing the required fields:
  - `inputs`
    - `mu`, `k`, `n`, `param.time`, `prot.runload`, `intervals1, intervals2, intervals3`
  - `viscoresults`
    - `alphavect`, `Wvect`

## Installation & Usage
### 1. Clone this repository
```bash
git clone https://github.com/your-username/matlab-feature-extraction.git
cd matlab-feature-extraction
```
### 2. Run the MATLAB script
- Open MATLAB and navigate to the project folder.
- Run the script:
```matlab
run('feature_extraction.m')
```

### 3. Output Files
- `saved_data_collection.mat` : Raw extracted features
- `saved_finalist.mat` : Processed feature matrix
- `Seq2Seq/slice_1.csv` : Time series slice
- `Seq2Seq/slice_2.csv` : Displacement slice
- `Seq2Seq/slice_3.csv` : Force slice
- `Seq2Seq/slice_4.csv` : Tabor parameter slice

## Visualization
The script automatically generates plots for each dataset, displaying:
- **Time series** (Blue)
- **Displacement** (Red)
- **Force** (Green)
- **Additional Data (if applicable)** (Magenta)

Press **Enter** to proceed through plots.

## License
This project is licensed under the MIT License.

## Author
Ali Maghami
Politecnico di Bari, Italy, TU Berlin, Germany  
a.maghami@phd.poliba.it

---
Happy coding! 🚀

