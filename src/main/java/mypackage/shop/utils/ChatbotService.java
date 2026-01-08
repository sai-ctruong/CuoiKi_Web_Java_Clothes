package mypackage.shop.utils;

import java.util.*;

/**
 * Service xử lý chatbot tự động trả lời FAQ
 * Sử dụng rule-based matching với keywords
 */
public class ChatbotService {
    
    private static final List<FAQRule> faqRules = new ArrayList<>();
    
    // Khởi tạo danh sách FAQ
    static {
        // Lời chào
        faqRules.add(new FAQRule(
            Arrays.asList("chào", "hello", "hi", "xin chào", "alo", "hey"),
            "Xin chào! 👋 Tôi là trợ lý ảo của Clothing Shop. Tôi có thể giúp bạn:\n" +
            "• Thông tin giao hàng\n" +
            "• Chính sách đổi trả\n" +
            "• Phương thức thanh toán\n" +
            "• Kiểm tra đơn hàng\n" +
            "Bạn cần hỗ trợ gì ạ?"
        ));
        
        // Thời gian giao hàng
        faqRules.add(new FAQRule(
            Arrays.asList("giao hàng", "ship", "delivery", "vận chuyển", "bao lâu", "mấy ngày", "thời gian giao"),
            "📦 **Thời gian giao hàng:**\n" +
            "• Nội thành TP.HCM: 1-2 ngày\n" +
            "• Các tỉnh miền Nam: 2-3 ngày\n" +
            "• Miền Trung & Bắc: 3-5 ngày\n\n" +
            "🎁 **Miễn phí ship** cho đơn hàng từ 500.000đ!"
        ));
        
        // Phí ship
        faqRules.add(new FAQRule(
            Arrays.asList("phí ship", "phí giao", "tiền ship", "ship bao nhiêu", "phí vận chuyển"),
            "💰 **Phí vận chuyển:**\n" +
            "• Đơn từ 500K: MIỄN PHÍ SHIP 🎉\n" +
            "• Đơn dưới 500K: 30.000đ toàn quốc\n\n" +
            "Mẹo: Mua thêm để được freeship nhé! 😊"
        ));
        
        // Đổi trả
        faqRules.add(new FAQRule(
            Arrays.asList("đổi trả", "trả hàng", "hoàn tiền", "return", "đổi size", "đổi sản phẩm"),
            "🔄 **Chính sách đổi trả:**\n" +
            "• Đổi trả miễn phí trong 7 ngày\n" +
            "• Sản phẩm còn nguyên tag, chưa qua sử dụng\n" +
            "• Hoàn tiền trong 3-5 ngày làm việc\n\n" +
            "📞 Liên hệ Hotline 1900 1234 để được hỗ trợ đổi trả!"
        ));
        
        // Thanh toán
        faqRules.add(new FAQRule(
            Arrays.asList("thanh toán", "payment", "cod", "trả tiền", "chuyển khoản", "banking"),
            "💳 **Phương thức thanh toán:**\n" +
            "• COD - Thanh toán khi nhận hàng\n" +
            "• Chuyển khoản ngân hàng\n\n" +
            "💡 Thanh toán COD hoàn toàn miễn phí, không phụ thu!"
        ));
        
        // Liên hệ
        faqRules.add(new FAQRule(
            Arrays.asList("liên hệ", "hotline", "số điện thoại", "phone", "email", "hỗ trợ", "gọi", "contact"),
            "📞 **Thông tin liên hệ:**\n" +
            "• Hotline: 1900 1234 (8:00-22:00)\n" +
            "• Email: info@clothingshop.com\n" +
            "• Địa chỉ: Số 1 Võ Văn Ngân, Thủ Đức, TP.HCM\n\n" +
            "Nhân viên CSKH luôn sẵn sàng hỗ trợ bạn! 💁"
        ));
        
        // Đơn hàng
        faqRules.add(new FAQRule(
            Arrays.asList("đơn hàng", "order", "tracking", "theo dõi", "kiểm tra đơn", "tình trạng đơn"),
            "📋 **Kiểm tra đơn hàng:**\n" +
            "1. Đăng nhập tài khoản\n" +
            "2. Vào mục 'Lịch sử đơn hàng'\n" +
            "3. Xem chi tiết và trạng thái đơn\n\n" +
            "🔗 Hoặc liên hệ Hotline 1900 1234 với mã đơn hàng để được hỗ trợ!"
        ));
        
        // Voucher
        faqRules.add(new FAQRule(
            Arrays.asList("voucher", "mã giảm giá", "khuyến mãi", "giảm giá", "coupon", "sale", "ưu đãi"),
            "🎫 **Mã giảm giá:**\n" +
            "• Xem voucher đang có tại trang chủ\n" +
            "• Kiểm tra 'Ví Voucher' trong tài khoản\n" +
            "• Follow Facebook/Instagram để nhận mã mới!\n\n" +
            "💡 Mẹo: Đăng ký thành viên mới nhận ngay voucher 10%!"
        ));
        
        // Size
        faqRules.add(new FAQRule(
            Arrays.asList("size", "kích thước", "kích cỡ", "bảng size", "chọn size", "size nào", "form"),
            "📏 **Hướng dẫn chọn size:**\n" +
            "• Bảng size chi tiết có trong mỗi sản phẩm\n" +
            "• Đo số đo và so sánh với bảng\n" +
            "• Nếu phân vân, chọn size lớn hơn\n\n" +
            "❓ Cần tư vấn size cụ thể? Gọi 1900 1234 nhé!"
        ));
        
        // Chất liệu
        faqRules.add(new FAQRule(
            Arrays.asList("chất liệu", "vải", "cotton", "polyester", "material"),
            "🧵 **Chất liệu sản phẩm:**\n" +
            "• Thông tin chất liệu có trong mô tả sản phẩm\n" +
            "• Chúng tôi cam kết 100% chính hãng\n" +
            "• Hình ảnh thực tế, không chỉnh sửa\n\n" +
            "Mọi sản phẩm đều được kiểm tra chất lượng trước khi gửi!"
        ));
        
        // Cảm ơn
        faqRules.add(new FAQRule(
            Arrays.asList("cảm ơn", "thanks", "thank you", "tks", "thankiu", "ok", "được rồi"),
            "Rất vui được hỗ trợ bạn! 😊\n\n" +
            "Nếu cần thêm thông tin, đừng ngại hỏi nhé!\n" +
            "Chúc bạn mua sắm vui vẻ! 🛍️"
        ));
        
        // Tạm biệt
        faqRules.add(new FAQRule(
            Arrays.asList("bye", "tạm biệt", "goodbye", "bai", "bb"),
            "Hẹn gặp lại bạn! 👋\n\n" +
            "Cảm ơn bạn đã ghé thăm Clothing Shop!\n" +
            "Chúc bạn một ngày tốt lành! ✨"
        ));
    }
    
    /**
     * Xử lý tin nhắn và trả về response phù hợp
     */
    public static String getResponse(String userMessage) {
        if (userMessage == null || userMessage.trim().isEmpty()) {
            return getDefaultResponse();
        }
        
        String normalizedMessage = userMessage.toLowerCase().trim();
        
        // Tìm rule phù hợp nhất
        FAQRule bestMatch = null;
        int maxMatchCount = 0;
        
        for (FAQRule rule : faqRules) {
            int matchCount = rule.countMatches(normalizedMessage);
            if (matchCount > maxMatchCount) {
                maxMatchCount = matchCount;
                bestMatch = rule;
            }
        }
        
        if (bestMatch != null && maxMatchCount > 0) {
            return bestMatch.getResponse();
        }
        
        return getDefaultResponse();
    }
    
    /**
     * Response mặc định khi không match được câu hỏi
     */
    private static String getDefaultResponse() {
        return "Xin lỗi, tôi chưa hiểu câu hỏi của bạn. 🤔\n\n" +
               "Bạn có thể hỏi về:\n" +
               "• Giao hàng và phí ship\n" +
               "• Chính sách đổi trả\n" +
               "• Phương thức thanh toán\n" +
               "• Kiểm tra đơn hàng\n" +
               "• Voucher giảm giá\n\n" +
               "Hoặc liên hệ Hotline 1900 1234 để được hỗ trợ trực tiếp!";
    }
    
    /**
     * Lấy tin nhắn chào mừng ban đầu
     */
    public static String getWelcomeMessage() {
        return "Xin chào! 👋\n\n" +
               "Tôi là trợ lý ảo của **Clothing Shop**.\n" +
               "Tôi có thể giúp bạn:\n" +
               "• Thông tin giao hàng\n" +
               "• Chính sách đổi trả\n" +
               "• Phương thức thanh toán\n" +
               "• Voucher giảm giá\n\n" +
               "Hãy đặt câu hỏi, tôi sẽ cố gắng giúp bạn! 😊";
    }
    
    /**
     * Class định nghĩa một rule FAQ
     */
    private static class FAQRule {
        private final List<String> keywords;
        private final String response;
        
        public FAQRule(List<String> keywords, String response) {
            this.keywords = keywords;
            this.response = response;
        }
        
        /**
         * Đếm số keyword match trong message
         */
        public int countMatches(String message) {
            int count = 0;
            for (String keyword : keywords) {
                if (message.contains(keyword)) {
                    count++;
                }
            }
            return count;
        }
        
        public String getResponse() {
            return response;
        }
    }
}
