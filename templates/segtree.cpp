struct SEGTREE {
  int n;
  vector<int> tree;

  SEGTREE(int n) : n(n), tree(2 * n, 0) {}

  SEGTREE(vector<int> &a) : n(a.size()), tree(2 * n, 0) {
    for (int i = 0; i < n; i++)
      tree[n + i] = a[i];
    for (int i = n - 1; i > 0; --i)
      tree[i] = tree[2 * i] + tree[2 * i + 1];
  }

  void update(int i, int value) {
    i += n;
    tree[i] = value;
    for (tree[i] = value; i > 1; i >>= 1) {
      tree[i >> 1] = tree[i] + tree[i ^ 1];
    }
  }

  int query(int l, int r) {
    int res = 0;
    l += n;
    r += n;
    while (l <= r) {
      if (l & 1) {
        res += tree[l++];
      }
      if (r & 1) {
        res += tree[r--];
      }
      l >>= 1;
      r >>= 1;
    }
    return res;
  }
};
