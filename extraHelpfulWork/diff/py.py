import os


def main():
    fp = raw_input('Filename: ')
    if fp and os.path.isfile(fp):
        with open(fp, 'r') as f:
            txt = f.read()
        newfp = '{0}_upper{1}'.format(*os.path.splitext(fp))
        with open(newfp, 'w') as f:
            f.write(txt.upper())


if __name__ == '__main__':
    main()