import sys


def main(args):
    with open(args[1], 'rb') as file:
        data = file.read()
        #with open(args[1].replace("bin", "txt"), "w") as f:
        with open('ram.hex', "w") as f:
            for b in data:
                f.write(hex(b)[2:])
                f.write('\n')

if (__name__ == '__main__'):
    main(sys.argv)