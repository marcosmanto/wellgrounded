sword = "épée"
sword_mac = sword.encode("macRoman")
p sword.bytes # [195, 169, 112, 195, 169, 101]
p sword_mac.bytes # [142, 112, 142, 101]
File.write("C:/Users/marcos.filho/Desktop/text_mac", sword_mac)
File.write('C:/Users/marcos.filho/Desktop/text_mac', sword_mac)
File.write("C:\\Users\\marcos.filho\\Desktop\\text_mac", sword_mac)
File.write('C:\Users\marcos.filho\Desktop\text_mac', sword_mac)