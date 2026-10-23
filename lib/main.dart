import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const ZadenApp());

class ZadenApp extends StatelessWidget {
  const ZadenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'زَادَن | ZADEN',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ZadenTheme.data,
      home: const ZadenHome(),
    );
  }
}

abstract final class ZadenColors {
  static const black = Color(0xFF0D0D0D);
  static const surface = Color(0xFF171717);
  static const surface2 = Color(0xFF202020);
  static const gold = Color(0xFFD4AF37);
  static const goldLight = Color(0xFFE8D17A);
  static const white = Color(0xFFF7F7F7);
  static const grey = Color(0xFFA7A7A7);
  static const green = Color(0xFF43B581);
  static const red = Color(0xFFE35D5D);
}

abstract final class ZadenTheme {
  static ThemeData get data {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: ZadenColors.black,
      colorScheme: const ColorScheme.dark(
        primary: ZadenColors.gold,
        onPrimary: ZadenColors.black,
        secondary: ZadenColors.goldLight,
        onSecondary: ZadenColors.black,
        surface: ZadenColors.surface,
        onSurface: ZadenColors.white,
        error: ZadenColors.red,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: ZadenColors.black,
        foregroundColor: ZadenColors.white,
        elevation: 0,
        centerTitle: false,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ZadenColors.surface2,
        hintStyle: const TextStyle(color: ZadenColors.grey),
        prefixIconColor: ZadenColors.gold,
        suffixIconColor: ZadenColors.grey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(14)),
          borderSide: BorderSide(color: ZadenColors.gold, width: 1.3),
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: ZadenColors.surface,
        indicatorColor: Color(0xFF3A3017),
        labelTextStyle: MaterialStatePropertyAll(
          TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
      ),
      cardTheme: CardTheme(
        color: ZadenColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(18)),
          side: BorderSide(color: Color(0xFF2D2D2D)),
        ),
      ),
    );
  }
}

enum AccountRole { customer, store, restaurant, driver }

extension AccountRoleX on AccountRole {
  String get title => switch (this) {
        AccountRole.customer => 'عميل',
        AccountRole.store => 'صاحب متجر',
        AccountRole.restaurant => 'صاحب مطعم',
        AccountRole.driver => 'مندوب توصيل',
      };

  IconData get icon => switch (this) {
        AccountRole.customer => Icons.person_outline,
        AccountRole.store => Icons.storefront_outlined,
        AccountRole.restaurant => Icons.restaurant_outlined,
        AccountRole.driver => Icons.delivery_dining_outlined,
      };
}

class Product {
  const Product({
    required this.id,
    required this.name,
    required this.store,
    required this.category,
    required this.price,
    required this.icon,
  });
  final int id;
  final String name;
  final String store;
  final String category;
  final double price;
  final IconData icon;
}

class StoreItem {
  const StoreItem({
    required this.name,
    required this.category,
    required this.rating,
    required this.delivery,
    required this.icon,
  });
  final String name;
  final String category;
  final double rating;
  final String delivery;
  final IconData icon;
}

const stores = <StoreItem>[
  StoreItem(name: 'شموخ اليمن', category: 'مطاعم', rating: 4.8, delivery: '25–35 د', icon: Icons.restaurant),
  StoreItem(name: 'سوبر ماركت النخبة', category: 'بقالة', rating: 4.6, delivery: '15–25 د', icon: Icons.local_grocery_store),
  StoreItem(name: 'مخبز المدينة', category: 'مخبوزات', rating: 4.7, delivery: '20–30 د', icon: Icons.bakery_dining),
  StoreItem(name: 'سوق زَادَن', category: 'متجر', rating: 4.5, delivery: '20–30 د', icon: Icons.shopping_bag),
];

const products = <Product>[
  Product(id: 1, name: 'وجبة دجاج مشوي', store: 'شموخ اليمن', category: 'مطاعم', price: 1800, icon: Icons.restaurant_menu),
  Product(id: 2, name: 'بيتزا خضار', store: 'شموخ اليمن', category: 'مطاعم', price: 2200, icon: Icons.local_pizza),
  Product(id: 3, name: 'أرز بسمتي 5 كجم', store: 'سوبر ماركت النخبة', category: 'بقالة', price: 5200, icon: Icons.rice_bowl),
  Product(id: 4, name: 'مياه معدنية', store: 'سوبر ماركت النخبة', category: 'بقالة', price: 700, icon: Icons.water_drop),
  Product(id: 5, name: 'خبز طازج', store: 'مخبز المدينة', category: 'مخبوزات', price: 500, icon: Icons.bakery_dining),
  Product(id: 6, name: 'حلويات مشكلة', store: 'مخبز المدينة', category: 'حلويات', price: 2500, icon: Icons.cake),
];

class CartLine {
  CartLine(this.product, this.quantity);
  final Product product;
  int quantity;
  double get total => product.price * quantity;
}

class OrderInfo {
  OrderInfo({required this.id, required this.lines, required this.total});
  final String id;
  final List<CartLine> lines;
  final double total;
  final DateTime createdAt = DateTime.now();
}

class ZadenHome extends StatefulWidget {
  const ZadenHome({super.key});

  @override
  State<ZadenHome> createState() => _ZadenHomeState();
}

class _ZadenHomeState extends State<ZadenHome> {
  int tab = 0;
  AccountRole role = AccountRole.customer;
  final cart = <int, CartLine>{};
  final orders = <OrderInfo>[];

  int get cartCount => cart.values.fold(0, (sum, line) => sum + line.quantity);
  double get cartTotal => cart.values.fold(0, (sum, line) => sum + line.total);

  void addToCart(Product product) {
    setState(() {
      final existing = cart[product.id];
      if (existing == null) {
        cart[product.id] = CartLine(product, 1);
      } else {
        existing.quantity++;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تمت إضافة ${product.name} إلى السلة')),
    );
  }

  void changeQuantity(int id, int delta) {
    setState(() {
      final line = cart[id];
      if (line == null) return;
      line.quantity += delta;
      if (line.quantity <= 0) cart.remove(id);
    });
  }

  void checkout() {
    if (cart.isEmpty) return;
    final newOrder = OrderInfo(
      id: '#ZD${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      lines: cart.values.map((e) => CartLine(e.product, e.quantity)).toList(),
      total: cartTotal,
    );
    setState(() {
      orders.insert(0, newOrder);
      cart.clear();
      tab = 3;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم تأكيد الطلب بنجاح')),
    );
  }

  void openRolePicker() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: ZadenColors.surface,
      showDragHandle: true,
      builder: (context) => Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('نوع الحساب', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            const SizedBox(height: 14),
            for (final item in AccountRole.values)
              ListTile(
                leading: Icon(item.icon, color: ZadenColors.gold),
                title: Text(item.title),
                trailing: role == item ? const Icon(Icons.check, color: ZadenColors.gold) : null,
                onTap: () {
                  setState(() => role = item);
                  Navigator.pop(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeTab(onAdd: addToCart),
      DiscoverTab(onAdd: addToCart),
      CartTab(cart: cart, total: cartTotal, onChange: changeQuantity, onCheckout: checkout),
      OrdersTab(orders: orders),
    ];

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 18,
          title: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('زَادَن', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: 1)),
              Text('يوصلك وين ما كنت', style: TextStyle(fontSize: 11, color: ZadenColors.gold, fontWeight: FontWeight.w600)),
            ],
          ),
          actions: [
            IconButton(onPressed: openRolePicker, icon: Icon(role.icon)),
            const SizedBox(width: 8),
          ],
        ),
        body: IndexedStack(index: tab, children: pages),
        bottomNavigationBar: NavigationBar(
          selectedIndex: tab,
          onDestinationSelected: (value) => setState(() => tab = value),
          destinations: [
            const NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'الرئيسية'),
            const NavigationDestination(icon: Icon(Icons.search), label: 'اكتشف'),
            NavigationDestination(
              icon: Badge(isLabelVisible: cartCount > 0, label: Text('$cartCount'), child: const Icon(Icons.shopping_cart_outlined)),
              selectedIcon: Badge(isLabelVisible: cartCount > 0, label: Text('$cartCount'), child: const Icon(Icons.shopping_cart)),
              label: 'السلة',
            ),
            const NavigationDestination(icon: Icon(Icons.receipt_long_outlined), label: 'طلباتي'),
          ],
        ),
      ),
    );
  }
}

class ZadenLogoMark extends StatelessWidget {
  const ZadenLogoMark({super.key, this.size = 54});
  final double size;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * .24),
        border: Border.all(color: ZadenColors.gold, width: 1.4),
        gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [ZadenColors.surface2, ZadenColors.black]),
      ),
      child: Center(child: Text('Z', style: TextStyle(color: ZadenColors.gold, fontSize: size * .55, fontWeight: FontWeight.w900))),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({super.key, required this.onAdd});
  final ValueChanged<Product> onAdd;
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
      children: [
        const _WelcomeCard(),
        const SizedBox(height: 18),
        const Text('الأقسام', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        SizedBox(
          height: 98,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: const ['مطاعم', 'بقالة', 'مخبوزات', 'متاجر'].length,
            separatorBuilder: (_, __) => const SizedBox(width: 10),
            itemBuilder: (_, index) {
              final labels = ['مطاعم', 'بقالة', 'مخبوزات', 'متاجر'];
              final icons = [Icons.restaurant, Icons.local_grocery_store, Icons.bakery_dining, Icons.shopping_bag];
              return _CategoryCard(label: labels[index], icon: icons[index]);
            },
          ),
        ),
        const SizedBox(height: 22),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('الأكثر طلبًا', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
          TextButton(onPressed: () {}, child: const Text('عرض الكل')),
        ]),
        const SizedBox(height: 8),
        for (final product in products.take(4)) ...[
          _ProductTile(product: product, onAdd: () => onAdd(product)),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 10),
        const Text('متاجر قريبة', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
        const SizedBox(height: 10),
        for (final store in stores.take(3)) _StoreTile(store: store),
      ],
    );
  }
}

class _WelcomeCard extends StatelessWidget {
  const _WelcomeCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(colors: [Color(0xFF29230F), ZadenColors.surface]),
        border: Border.all(color: const Color(0xFF5B4A1A)),
      ),
      child: Row(children: [
        const ZadenLogoMark(size: 58),
        const SizedBox(width: 14),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('أهلاً بك في زَادَن', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
          SizedBox(height: 5),
          Text('اطلب أكلك ومشترياتك من مكان واحد.', style: TextStyle(color: ZadenColors.grey, height: 1.4)),
        ])),
      ]),
    );
  }
}

class DiscoverTab extends StatefulWidget {
  const DiscoverTab({super.key, required this.onAdd});
  final ValueChanged<Product> onAdd;
  @override
  State<DiscoverTab> createState() => _DiscoverTabState();
}

class _DiscoverTabState extends State<DiscoverTab> {
  final controller = TextEditingController();
  String category = 'الكل';
  @override
  void dispose() { controller.dispose(); super.dispose(); }
  @override
  Widget build(BuildContext context) {
    final query = controller.text.trim().toLowerCase();
    final filtered = products.where((p) {
      final matchesText = query.isEmpty || p.name.toLowerCase().contains(query) || p.store.toLowerCase().contains(query);
      final matchesCategory = category == 'الكل' || p.category == category;
      return matchesText && matchesCategory;
    }).toList();
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 12, 18, 24),
      children: [
        const Text('اكتشف', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        TextField(controller: controller, onChanged: (_) => setState(() {}), decoration: const InputDecoration(hintText: 'ابحث عن مطعم، متجر أو منتج', prefixIcon: Icon(Icons.search))),
        const SizedBox(height: 12),
        SizedBox(
          height: 42,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: ['الكل', 'مطاعم', 'بقالة', 'مخبوزات', 'حلويات'].map((item) => Padding(
              padding: const EdgeInsets.only(left: 8),
              child: ChoiceChip(label: Text(item), selected: category == item, onSelected: (_) => setState(() => category = item)),
            )).toList(),
          ),
        ),
        const SizedBox(height: 18),
        if (filtered.isEmpty) const _EmptyState(text: 'ما لقينا نتائج مطابقة.'),
        for (final product in filtered) ...[
          _ProductTile(product: product, onAdd: () => widget.onAdd(product)),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class CartTab extends StatelessWidget {
  const CartTab({super.key, required this.cart, required this.total, required this.onChange, required this.onCheckout});
  final Map<int, CartLine> cart;
  final double total;
  final void Function(int id, int delta) onChange;
  final VoidCallback onCheckout;
  @override
  Widget build(BuildContext context) {
    if (cart.isEmpty) return const _EmptyState(text: 'السلة فارغة\nأضف منتجات من قسم اكتشف.');
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
      children: [
        const Text('سلة المشتريات', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
        const SizedBox(height: 16),
        for (final line in cart.values) ...[
          Card(
            child: Padding(
              padding: const EdgeInsets.all(13),
              child: Row(children: [
                Container(width: 52, height: 52, decoration: BoxDecoration(color: ZadenColors.surface2, borderRadius: BorderRadius.circular(14)), child: Icon(line.product.icon, color: ZadenColors.gold)),
                const SizedBox(width: 12),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(line.product.name, style: const TextStyle(fontWeight: FontWeight.w800)),
                  Text('${line.product.price.toStringAsFixed(0)} ريال', style: const TextStyle(color: ZadenColors.gold)),
                ])),
                Row(children: [
                  IconButton(onPressed: () => onChange(line.product.id, -1), icon: const Icon(Icons.remove_circle_outline)),
                  Text('${line.quantity}', style: const TextStyle(fontWeight: FontWeight.w900)),
                  IconButton(onPressed: () => onChange(line.product.id, 1), icon: const Icon(Icons.add_circle_outline, color: ZadenColors.gold)),
                ]),
              ]),
            ),
          ),
          const SizedBox(height: 10),
        ],
        const SizedBox(height: 8),
        Card(child: Padding(padding: const EdgeInsets.all(18), child: Column(children: [
          _SummaryRow(label: 'الإجمالي', value: '${total.toStringAsFixed(0)} ريال'),
          const SizedBox(height: 8),
          const _SummaryRow(label: 'التوصيل', value: 'يُحدد عند العنوان'),
          const Divider(height: 24),
          const Align(alignment: Alignment.centerRight, child: Text('الدفع عند الاستلام', style: TextStyle(color: ZadenColors.green, fontWeight: FontWeight.w800))),
        ]))),
        const SizedBox(height: 16),
        FilledButton.icon(onPressed: onCheckout, icon: const Icon(Icons.check_circle_outline), label: const Text('تأكيد الطلب')),
      ],
    );
  }
}

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key, required this.orders});
  final List<OrderInfo> orders;
  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) return const _EmptyState(text: 'لا توجد طلبات حتى الآن.\nطلباتك الجديدة ستظهر هنا.');
    return ListView(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
      children: [
        const Text('طلباتي', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
        const SizedBox(height: 16),
        for (final order in orders) Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(order.id, style: const TextStyle(color: ZadenColors.gold, fontWeight: FontWeight.w900)),
                const Text('قيد التجهيز', style: TextStyle(color: ZadenColors.green, fontWeight: FontWeight.w800)),
              ]),
              const SizedBox(height: 8),
              Text('${order.lines.length} منتجات • ${order.total.toStringAsFixed(0)} ريال', style: const TextStyle(color: ZadenColors.grey)),
              const SizedBox(height: 16),
              const _OrderTimeline(),
            ]),
          ),
        ),
      ],
    );
  }
}

class _OrderTimeline extends StatelessWidget {
  const _OrderTimeline();
  @override
  Widget build(BuildContext context) {
    const steps = ['تم استلام الطلب', 'قيد التجهيز', 'خرج للتوصيل', 'تم التسليم'];
    return Column(children: [
      for (var i = 0; i < steps.length; i++) Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(children: [
          Icon(i <= 1 ? Icons.check_circle : Icons.radio_button_unchecked, size: 19, color: i <= 1 ? ZadenColors.gold : ZadenColors.grey),
          if (i != steps.length - 1) Container(width: 1, height: 24, color: ZadenColors.grey),
        ]),
        const SizedBox(width: 10),
        Padding(padding: const EdgeInsets.only(top: 1), child: Text(steps[i], style: TextStyle(fontWeight: i == 1 ? FontWeight.w800 : FontWeight.w500, color: i <= 1 ? ZadenColors.white : ZadenColors.grey))),
      ]),
    ]);
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.product, required this.onAdd});
  final Product product;
  final VoidCallback onAdd;
  @override
  Widget build(BuildContext context) {
    return Card(child: Padding(padding: const EdgeInsets.all(12), child: Row(children: [
      Container(width: 62, height: 62, decoration: BoxDecoration(color: ZadenColors.surface2, borderRadius: BorderRadius.circular(15)), child: Icon(product.icon, color: ZadenColors.gold, size: 30)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(product.name, style: const TextStyle(fontWeight: FontWeight.w900)),
        const SizedBox(height: 4),
        Text(product.store, style: const TextStyle(color: ZadenColors.grey, fontSize: 12)),
        const SizedBox(height: 5),
        Text('${product.price.toStringAsFixed(0)} ريال', style: const TextStyle(color: ZadenColors.gold, fontWeight: FontWeight.w800)),
      ])),
      IconButton(onPressed: onAdd, style: IconButton.styleFrom(backgroundColor: const Color(0xFF332B14)), icon: const Icon(Icons.add, color: ZadenColors.gold)),
    ])));
  }
}

class _StoreTile extends StatelessWidget {
  const _StoreTile({required this.store});
  final StoreItem store;
  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.only(bottom: 10), child: Card(child: ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
      leading: CircleAvatar(backgroundColor: const Color(0xFF332B14), child: Icon(store.icon, color: ZadenColors.gold)),
      title: Text(store.name, style: const TextStyle(fontWeight: FontWeight.w800)),
      subtitle: Text('${store.category} • ${store.delivery}'),
      trailing: Text('★ ${store.rating}', style: const TextStyle(color: ZadenColors.gold, fontWeight: FontWeight.w800)),
    )));
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({required this.label, required this.icon});
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(width: 92, padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: ZadenColors.surface, borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFF2B2B2B))), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: ZadenColors.gold, size: 28), const SizedBox(height: 7), Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800))]));
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: const TextStyle(color: ZadenColors.grey)), Text(value, style: const TextStyle(fontWeight: FontWeight.w900))]);
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Center(child: Padding(padding: const EdgeInsets.all(35), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [const ZadenLogoMark(size: 70), const SizedBox(height: 18), Text(text, textAlign: TextAlign.center, style: const TextStyle(color: ZadenColors.grey, height: 1.6, fontSize: 15))])));
}