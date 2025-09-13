import kagglehub
import pandas as pd

csv_path = './assets/ks-projects-201801.csv'

df = pd.read_csv(csv_path, sep=",", index_col=0)

print(df.count())

print(df)
