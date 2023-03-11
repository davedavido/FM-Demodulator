import numpy as np

fm_real = np.int32(np.genfromtxt('/Users/Davidlohner/Documents/FM-Demodulator/Python/fm_signal_real_fs_200kHz.dat'))

fm_imag = np.int32(np.genfromtxt('/Users/Davidlohner/Documents/FM-Demodulator/Python/fm_signal_imag_fs_200kHz.dat'))

fm_merged_32 = (fm_real << 16) | (fm_imag & 0xFFFF)

np.savetxt('/Users/Davidlohner/Documents/FM-Demodulator/Python/fm_merged_32.txt', fm_merged_32, fmt = '%d')
