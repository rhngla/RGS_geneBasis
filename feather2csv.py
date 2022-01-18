import feather
import pandas as pd
import argparse 

parser = argparse.ArgumentParser()
parser.add_argument("--fname", default='', type=str, help="file name, without extension")


def main(fname):
    df = feather.read_dataframe(f'{fname}.feather')
    df.to_csv(f'{fname}.csv', index=False)
    return

if __name__ == '__main__':
    args = parser.parse_args()
    main(**vars(args))
