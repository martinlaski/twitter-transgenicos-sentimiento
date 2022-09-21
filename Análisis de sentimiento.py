# -*- coding: utf-8 -*-
"""
Created on Wed Sep 21 12:39:39 2022

@author: marto
"""

#Análisis de sentimiento tweets
import pandas as pd

df = pd.read_csv (r'C:\Datasets\News\tweets_final.csv', on_bad_lines='skip')
print(df)

from pysentimiento import analyzer
sentiment_en = analyzer.SentimentAnalyzer(lang='es') # similar to "es"
emotion_en = analyzer.EmotionAnalyzer(lang='es') # similar to "es"

def process(row):
    res = sentiment_en.predict(row["text"])
    return pd.Series({'sentiment': res.output, **res.probas})


df = df.join(df.apply(process, axis=1))


df.to_csv('Dataset final sentimiento.csv', sep=';', index=False)