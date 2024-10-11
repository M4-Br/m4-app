class GroupAccount {
  final int id;
  final int userId;
  final String name;
  final String startAt;
  final bool agentWasMembership;
  final String period;
  final double amountByPeriod;
  final int installment;
  final int quantityOfMembers;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String finishDate;
  final List<Member> members;

  GroupAccount({
    required this.id,
    required this.userId,
    required this.name,
    required this.startAt,
    required this.agentWasMembership,
    required this.period,
    required this.amountByPeriod,
    required this.installment,
    required this.quantityOfMembers,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.finishDate,
    required this.members,
  });

  factory GroupAccount.fromJson(Map<String, dynamic> json) {
    return GroupAccount(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      startAt: json['start_at'],
      agentWasMembership: json['agent_was_membership'],
      period: json['period'],
      amountByPeriod: json['amount_by_period'],
      installment: json['installment'],
      quantityOfMembers: json['quantity_of_members'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      finishDate: json['finish_date'],
      members: List<Member>.from(json['members'].map((member) => Member.fromJson(member))),
    );
  }
}

class Member {
  final int id;
  final String name;
  final String email;
  final String document;
  final String status;
  final String createdAt;
  final String updatedAt;

  Member({
    required this.id,
    required this.name,
    required this.email,
    required this.document,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      document: json['document'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class InviteResponse {
  final int currentPage;
  final List<GroupAccount> data;
  final String firstPageUrl;
  final int from;
  final int lastPage;
  final String lastPageUrl;
  final List<Link> links;
  final String? nextPageUrl;
  final String path;
  final int perPage;
  final String? prevPageUrl;
  final int to;
  final int total;

  InviteResponse({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  factory InviteResponse.fromJson(Map<String, dynamic> json) {
    return InviteResponse(
      currentPage: json['current_page'],
      data: List<GroupAccount>.from(json['data'].map((groupAccount) => GroupAccount.fromJson(groupAccount))),
      firstPageUrl: json['first_page_url'],
      from: json['from'],
      lastPage: json['last_page'],
      lastPageUrl: json['last_page_url'],
      links: List<Link>.from(json['links'].map((link) => Link.fromJson(link))),
      nextPageUrl: json['next_page_url'],
      path: json['path'],
      perPage: json['per_page'],
      prevPageUrl: json['prev_page_url'],
      to: json['to'],
      total: json['total'],
    );
  }
}

class Link {
  final String? url;
  final String label;
  final bool active;

  Link({
    required this.url,
    required this.label,
    required this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) {
    return Link(
      url: json['url'],
      label: json['label'],
      active: json['active'],
    );
  }
}