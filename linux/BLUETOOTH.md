# Fixing Bluetooth Audio Stuttering on Linux (Intel AX201 + Sony Headphones)

### 🧠 Problem

Bluetooth audio kept breaking or stuttering when using **Sony WF-C710N** earphones on Linux.
This happened because the **Intel AX201 Bluetooth adapter** was being **autosuspended** by the kernel’s power management, despite TLP excluding Bluetooth devices.

---

### 🔍 Diagnosis

**Commands and findings:**

```bash
sudo tlp-stat -u
```

* `Autosuspend = enabled`
* `Exclude bluetooth = enabled`
  → But device still under `auto` control.

```bash
cat /sys/class/bluetooth/hci0:256/device/power/control
```

Output:

```
auto
```

→ Kernel still allowed autosuspend.

```bash
dmesg | grep -i bluetooth
```

Showed:

```
Bluetooth: hci0: SCO packet for unknown connection handle 257
```

→ Classic sign of controller sleeping mid-audio stream.

---

### 🛠️ Fix

#### 1. Disable runtime power management (temporary)

```bash
echo on | sudo tee /sys/class/bluetooth/hci0:256/device/power/control
```

Verify:

```bash
cat /sys/class/bluetooth/hci0:256/device/power/control
# should show: on
```

Reconnect Bluetooth headset and test.
This fixes audio dropouts immediately.

---

#### 2. Make the fix persistent

Create a **udev rule**:

```bash
sudo nano /etc/udev/rules.d/99-btusb-disable-autosuspend.rules
```

Add:

```
ACTION=="add", SUBSYSTEM=="bluetooth", KERNEL=="hci0*", TEST=="device/power/control", ATTR{device/power/control}="on"
```

Then reload:

```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
```

After reboot, verify again:

```bash
cat /sys/class/bluetooth/hci0*/device/power/control
# should show: on
```

---

### ✅ Result

* Bluetooth stays powered on.
* Audio streaming (AAC/A2DP) no longer breaks.
* Kernel logs clean (no more “SCO packet for unknown handle” errors).

---

### 🧩 Optional Stability Tweaks

If minor glitches persist, try forcing SBC codec:

```bash
pactl set-card-profile bluez_card.<MAC> a2dp-sink-sbc
```

This reduces codec complexity and keeps connection stable.

---

### 🪄 Summary

| Issue                       | Cause                                  | Fix                                                                                 |
| --------------------------- | -------------------------------------- | ----------------------------------------------------------------------------------- |
| Audio stuttering / dropouts | Intel Bluetooth controller autosuspend | Set `/sys/class/bluetooth/.../power/control` to `on` and make it permanent via udev |


