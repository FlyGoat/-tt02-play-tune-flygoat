
# Planetes
morse = "--•-• -••-- ••-   --•-- •- --•-• •-•-- -•--•      "

# FlyGoat
# morse = "..-. .-.. -.-- --. --- .- -      "

# BH5HSO
#morse = "-... .... ..... .... ... ---      "

# GM3HSO
# morse = "--. -- ...-- .... ... ---      "

t = 16
for char in morse:
    if char == "-":
        print(str(t * 3) + "d", end=",")
        print(str(t) + "p" , end=",")
    elif char == "•" or char == ".":
        print(str(t) + "d", end=",")
        print(str(t) + "p", end=",")
    elif char == " ":
        print(str(t * 2) + "p", end=",")
    else:
        print("ERROR")

