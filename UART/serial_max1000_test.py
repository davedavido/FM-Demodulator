import serial
import numpy as np
import serial.tools.list_ports
print('try to open COM Port')

l = list(serial.tools.list_ports.comports())
print(*l, sep="\n")

#Pre Formatted Input Data
data = np.loadtxt('fm_bytes.txt', dtype='int')

#Get 7.2 Million Samples
data_in = data[0:7200000].tolist()
#data_in = data[0:5000].tolist()

ser = serial.Serial('COM4', 115200, serial.EIGHTBITS, serial.PARITY_NONE, serial.STOPBITS_ONE, 0.1)

N = int(len(data_in)/500)

print(N)

output = np.zeros((N, int(len(data_in)/N)))

print('try to read from COM Port')

for i in range (N):
    print(i,'von',(N))
    ser.write(data_in[int(i*len(data_in)/N): int((i+1)*len(data_in)/N)])
    r = ser.read(len(data_in))

    mv = memoryview(r).cast('B')
    data_o = (np.array(mv))
    output[i, :] = data_o

print('data transfer successfull \n\rformatting output array ...')
x = output.reshape(1, len(data_in))

#delete first 4 Elements, 0 anyway
x_mod = np.delete(x, [0,1,2,3])

x_mod = np.array(x_mod, dtype=np.uint8)

#Zusammenfassen als 32-Bit signed int

fm_demod = np.zeros((len(x_mod)//4,), dtype=np.int32)

for i in range(0, len(x_mod), 4):
    val = x_mod[i] << np.int32(24) | x_mod[i+1] << np.int32(16) | x_mod[i+2] << np.int32(8) | x_mod[i+3]
    fm_demod[i//4] = np.int16(val)

np.savetxt('output_data.txt', X=fm_demod[5:], fmt='%d', delimiter= ' \n')

print('done')