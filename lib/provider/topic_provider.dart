enum Topic {
  wrong, // Câu hỏi sai (-4)
  hard, // Câu hỏi khó (-3)
  saved, // Câu hỏi đã lưu (-2)
  all, // Tât cả câu hỏi (-1)
  fallingPoint, // Câu hỏi điểm liệt (0)
  concept, // Khái niệm và quy tắc (1)
  transport, // Nghiệp vụ vận tải (2)
  culture, // Văn hóa và đạo đức (3)
  technique, // Kỹ thuật lái xe (4)
  structure, // Cấu tạo và sửa chữa (5)
  sign, // Biển báo đường bộ (6)
  practice, // Sa hình (7)
}

final kTopic = {
  -4: 'Câu hỏi sai',
  -3: 'Câu hỏi khó',
  -2: 'Câu hỏi đã lưu',
  -1: 'Tất cả câu hỏi',
  0: 'Câu hỏi điểm liệt',
  1: 'Khái niệm và quy tắc',
  2: 'Nghiệp vụ vận tải',
  3: 'Văn hóa và đạo đức',
  4: 'Kỹ thuật lái xe',
  5: 'Cấu tạo và sửa chữa',
  6: 'Biển báo đường bộ',
  7: 'Sa hình',
};