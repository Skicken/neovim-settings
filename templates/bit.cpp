struct BIT {
  vector<int> bit;
  int n;

  BIT(int n) : bit(n, 0), n(n) {}
  BIT(vector<int> &a) : BIT(a.size()) {

    for (int i = 0; i < n; i++) {
      bit[i] += a[i];
      int next = i | (i + 1);
      if (next < n) {
        bit[next] += bit[i];
      }
    }
  }

  int query(int r) {
    int s = 0;
    for (int i = r; i >= 0; i = (i & (i + 1)) - 1) {
      s += bit[i];
    }
    return s;
  }

  int query(int l, int r) { return query(r) - query(l - 1); }

  void update(int i, int d) {
    for (; i < n; i = i | (i + 1)) {
      bit[i] += d;
    }
  }
};
