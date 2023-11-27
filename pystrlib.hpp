#include <string>
#include <vector>
#include <tuple>
#include <algorithm>
#include <cctype>

namespace lib {

    std::string capitalize(const std::string &str) {
        std::string res = str;
        res[0] = std::toupper(res[0]);
        for (unsigned i = 1; i < str.size(); ++i)
            res[i] = std::tolower(res[i]);
        return res;
    }

    std::string casefold(const std::string &str) {
        std::string res = str;
        for (char &c : res) c = std::tolower(c);
        return res;
    }

    std::string center(const std::string &str, int width, char fill_char = ' ') {
        int pc = width - str.size();
        return std::string(pc >> 1, fill_char) + str + std::string(pc - (pc >> 1), fill_char);
    }

    int count(const std::string &str, const std::string &sub, int start = 0, int end = -1) {
        if (end < 0) end = str.size();
        int cnt = 0;
        for (int l = start; (int) (l + sub.size()) <= end; ++l) {
            bool match = true;
            for (unsigned j = 0; j < sub.size(); ++j)
                if (sub[j] != str[l + j]) { match = false; break; }
            if (match) ++cnt, l += sub.size();
        }
        return cnt;
    }
    
    bool ends_with(const std::string &str, const std::string &suffix, int start = 0, int end = -1) {
        if (end < 0) end = str.size();
        if ((unsigned) (end - start) < suffix.size()) return false;
        bool match = true;
        for (int j = suffix.size(), i = str.size(); j; ) {
            --i; --j;
            if (str[i] != suffix[j]) { match = false; break; }
        }
        return match;
    }
    
    bool starts_with(const std::string &str, const std::string &prefix, int start = 0, int end = -1) {
        if (end < 0) end = str.size();
        if ((unsigned) (end - start) < prefix.size()) return false;
        bool match = true;
        for (unsigned j = 0, i = start; j < prefix.size(); ++i, ++j)
            if (str[i] != prefix[j]) { match = false; break; }
        return match;
    }

    std::string expand_tabs(const std::string &str, int tab_size = 8) {
        std::string res;
        for (char ch : str) {
            if (ch == '\t') res += std::string(tab_size, ' ');
            else res += ch;
        }
        return res;
    }

    int find(const std::string &str, const std::string &sub, int start = 0, int end = -1) {
        if (end < 0) end = str.size();
        for (unsigned i = start; (int) (i + sub.size()) <= end; ++i) {
            bool match = true;
            for (unsigned j = 0; j < sub.size(); ++j)
                if (str[i + j] != sub[j]) { match = false; break; }
            if (match) return i;
        }
        return -1;
    }

    std::string join(const std::string &str, const std::vector<std::string> &slist) {
        bool is_first = true;
        std::string res;
        for (const std::string &s : slist) {
            if (is_first) is_first = false; else res += str;
            res += s;
        }
        return res;
    }

    std::string ljust(const std::string &str, int width, char fill_char = ' ') {
        return str + std::string(width - str.size(), fill_char);
    }

    std::string lower(const std::string &str) {
        std::string res = str;
        for (char &c : res) c = std::tolower(c);
        return res;
    }

    std::string lstrip(const std::string &str) {
        unsigned i = 0;
        while (i < str.size()) {
            if (!std::isspace(str[i])) break;
            ++i;
        }
        return str.substr(i);
    }

    std::string lstrip(const std::string &str, const std::string &char_set) {
        unsigned i = 0;
        while (i < str.size()) {
            bool in = false;
            for (char c : char_set)
                if (c == str[i]) { in = true; break; }
            if (!in) break;
            ++i;
        }
        return str.substr(i);
    }

    std::tuple< std::string, std::string, std::string > partition(const std::string &str, const std::string &sep) {
        int pos = find(str, sep);
        return pos == -1 ? std::make_tuple(str, "", "") : std::make_tuple(str.substr(0, pos), sep, str.substr(pos + sep.size()));
    }

    std::string remove_prefix(const std::string &str, const std::string &prefix) {
        return starts_with(str, prefix) ? str.substr(prefix.size()) : str;
    }

    std::string remove_suffix(const std::string &str, const std::string &suffix) {
        return ends_with(str, suffix) ? str.substr(0, str.size() - suffix.size()) : str;
    }

    std::string replace(const std::string &str, const std::string &old_sub, const std::string &new_sub, int count = INT_MAX) {
        int cnt = 0;
        std::string res;
        unsigned i = 0;
        for (; i <= str.size() - old_sub.size(); ) {
            bool match = true;
            for (unsigned j = 0; j < old_sub.size(); ++j)
                if (str[i + j] != old_sub[j]) { match = false; break; }
            if (match) res += new_sub, i += old_sub.size(), ++cnt;
            else res.push_back(str[i]), ++i;
            if (cnt == count) break;
        }
        return res + str.substr(i);
    }

    int rfind(const std::string &str, const std::string &sub, int start = 0, int end = -1) {
        if (end < 0) end = str.size();
        for (int i = end - sub.size(); i >= start; --i) {
            bool match = true;
            for (unsigned j = 0; j < sub.size(); ++j)
                if (str[i + j] != sub[j]) { match = false; break; }
            if (match) return i;
        }
        return -1;
    }

    std::string rjust(const std::string &str, int width, char fill_char = ' ') {
        return std::string(width - str.size(), fill_char) + str;
    }

    std::tuple< std::string, std::string, std::string > rpartition(const std::string &str, const std::string &sep) {
        int pos = rfind(str, sep);
        return pos == -1 ? std::make_tuple(str, "", "") : std::make_tuple(str.substr(0, pos), sep, str.substr(pos + sep.size()));
    }

    std::vector<std::string> rsplit(const std::string &str, const std::string &sep, int count = -1) {
        if (str.size() < sep.size()) return { str };
        int cnt = 0;
        std::vector<std::string> res;
        unsigned last = str.size();
        for (int i = str.size() - sep.size(); i >= 0; ) {
            bool match = true;
            for (unsigned j = 0; j < sep.size(); ++j)
                if (str[i + j] != sep[j]) { match = false; break; }
            if (match) ++cnt, res.push_back(str.substr(i + sep.size(), last - i - sep.size())), last = i, i -= sep.size();
            else --i;
            if (cnt == count) break;
        }
        res.push_back(str.substr(0, last));
        std::reverse(res.begin(), res.end());
        return res;
    }

    std::vector<std::string> split(const std::string &str, const std::string &sep, int count = -1) {
        if (str.size() < sep.size()) return { str };
        int cnt = 0;
        std::vector<std::string> res;
        unsigned last = 0;
        for (unsigned i = 0; i <= str.size() - sep.size(); ) {
            bool match = true;
            for (unsigned j = 0; j < sep.size(); ++j)
                if (str[i + j] != sep[j]) { match = false; break; }
            if (match) ++cnt, res.push_back(str.substr(last, i - last)), i += sep.size(), last = i;
            else ++i;
            if (cnt == count) break;
        }
        res.push_back(str.substr(last));
        return res;
    }

    std::string rstrip(const std::string &str) {
        int i = str.size() - 1;
        while (i >= 0) {
            if (!std::isspace(str[i])) break;
            --i;
        }
        return str.substr(0, i + 1);
    }

    std::string rstrip(const std::string &str, const std::string &char_set) {
        int i = str.size() - 1;
        while (i >= 0) {
            bool in = false;
            for (char c : char_set)
                if (c == str[i]) { in = true; break; }
            if (!in) break;
            --i;
        }
        return str.substr(0, i + 1);
    }

    std::string strip(const std::string &str) {
        return lstrip(rstrip(str));
    }

    std::string swapcase(const std::string &str) {
        std::string res;
        for (char ch : str) {
            if (std::islower(ch)) res.push_back(std::toupper(ch));
            else if (std::isupper(ch)) res.push_back(std::tolower(ch));
            else res.push_back(ch);
        }
        return res;
    }

    std::string upper(const std::string &str) {
        std::string res;
        for (char ch : str) res.push_back(std::toupper(ch));
        return res;
    }

}