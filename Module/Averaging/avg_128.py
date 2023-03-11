WINDOW_SIZE = 4

with open("Module/Averaging/testdata.txt", "r") as f:
  # Initialisiere das Schieberegister mit Nullen
  shift_register = [0.0] * WINDOW_SIZE

  output_samples = []
  for line in f:
    # Lese das aktuelle Eingangssample aus der Textdatei und formatiere es als float
    input_sample = float(line.strip())

    # Füge das aktuelle Sample am Ende des Schieberegisters hinzu und entferne das älteste Sample
    shift_register.append(input_sample)
    shift_register.pop(0)

    # Berechne den Mittelwert aus dem Schieberegister
    mean = sum(shift_register) / len(shift_register)

    # Ziehe den Mittelwert von dem aktuellen Sample ab und formatiere das Ausgangssample als float
    output_sample = input_sample - mean
    output_samples.append(output_sample)

with open("Module/Averaging/result.txt", "w") as f:
  # Schreibe die Ausgangswerte in eine Textdatei als float formatiert
  for sample in output_samples:
    f.write("{:.4f}\n".format(sample))
