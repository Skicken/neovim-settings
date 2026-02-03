struct DSU {
  vector<int> parent;
  vector<int> size;
  DSU(int n) : parent(n, -1), size(n, -1) {
    for (int i = 0; i < n; i++) {
      parent[i] = i;
      size[i] = 1;
    }
  }
  void set(int x) {
    parent[x] = x;
    size[x] = 1;
  }
  int find(int x) {
    if (parent[x] == x) {
      return x;
    }
    return parent[x] = findRep(parent[x]);
  }
  int size(int x) { return size[findRep(x)]; }

  void merge(int x, int y) {

    int px = find(x);
    int py = find(y);
    if (px == py) {
      return;
    }

    if (size[px] < size[py]) {
      swap(px, py);
    }
    size[px] += size[py];
    parent[py] = px;
  }
};
