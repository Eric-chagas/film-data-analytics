import pandas as pd

csv_paths = ['./assets/letterboxd/movies.csv',
             './assets/letterboxd/actors.csv', 
             './assets/letterboxd/movies.csv',
             './assets/letterboxd/movies.csv']

df = pd.read_csv('./bronze/letterboxd/movies.csv', sep=",", index_col=0)

print(df.count())

# print(df)
