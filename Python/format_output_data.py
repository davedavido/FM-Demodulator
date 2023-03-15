import numpy as np

filter_output = np.int16(np.genfromtxt('/Users/Davidlohner/Documents/FM-Demodulator/Python/demod_avg_filtered.txt'))

#Get Bytes 31:24 First

bytes = []
for i in range (len(filter_output)):
    a0 = filter_output[i] & 0xFF
    a1 = (filter_output[i]>>8) & 0xFF
    bytes.append(a1)
    bytes.append(a0)

np.savetxt('/Users/Davidlohner/Documents/FM-Demodulator/Python/Module_Output_bytes.txt', np.array(bytes), fmt = '%d')