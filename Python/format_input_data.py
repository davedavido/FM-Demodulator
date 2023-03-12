import numpy as np

fm_real = np.int32(np.genfromtxt('/Users/Davidlohner/Documents/FM-Demodulator/Python/fm_signal_real_fs_200kHz.dat'))

fm_imag = np.int32(np.genfromtxt('/Users/Davidlohner/Documents/FM-Demodulator/Python/fm_signal_imag_fs_200kHz.dat'))

fm_merged_32 = (fm_real << 16) | (fm_imag & 0xFFFF)

print(fm_merged_32.max(), fm_merged_32.min())

np.savetxt('/Users/Davidlohner/Documents/FM-Demodulator/Python/fm_merged_32.txt', fm_merged_32, fmt = '%d')

#Get Bytes 31:24 First

bytes = []
for i in range (len(fm_merged_32)):
    a0 = fm_merged_32[i] & 0xFF
    a1 = (fm_merged_32[i]>>8) & 0xFF
    a2 = (fm_merged_32[i]>>16) & 0xFF
    a3 = (fm_merged_32[i]>>24) & 0xFF
    bytes.append(a3)
    bytes.append(a2)
    bytes.append(a1)
    bytes.append(a0)

np.savetxt('/Users/Davidlohner/Documents/FM-Demodulator/Python/fm_bytes.txt', np.array(bytes), fmt = '%d')