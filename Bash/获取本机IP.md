
```bash
ifconfig | sed -e '/.*inet /!d;s///;s/ .*//' | tail -n 1

```