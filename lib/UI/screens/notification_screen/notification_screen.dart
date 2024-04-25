import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search),
                  hintText: 'Search Notification',
                  contentPadding: const EdgeInsets.all(16.0),
                  fillColor: Colors.black12,
                  filled: true,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20.0))),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Slidable(
                      endActionPane: ActionPane(
                        extentRatio: 0.4,
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (context) {},
                            icon: Icons.reply,
                            backgroundColor: Colors.grey[300]!,
                          ),
                          SlidableAction(
                            onPressed: (context) {},
                            icon: Icons.delete,
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red[800]!,
                          )
                        ],
                      ),
                      child: ListTile(
                        isThreeLine: true,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: size.width * 0.05),
                        leading: const CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/app_logo.png'),
                        ),
                        title: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Ali Nouman Ijaz',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '5h Ago',
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                        subtitle: const Text(
                          'How are you? My name is Ali Nouman Ijaz. This is new notification for you iaksjdfiojasdo;fijsdoifjsdiofjsdiofjisdjfisadofjosidfj',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        color: Colors.grey[400],
                        indent: size.width * .00,
                        endIndent: size.width * .00,
                      ),
                  itemCount: 10))
        ],
      ),
    );
  }
}
