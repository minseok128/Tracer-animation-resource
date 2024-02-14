#include <iostream>
#include <vector>
#include <queue>
#include <sstream>
#include <string>

using namespace std;

const int dx[] = {0, 0, -1, 1}; // 좌, 우, 상, 하 이동
const int dy[] = {-1, 1, 0, 0};

int main() {
    vector<string> pixels;
    string line;
    bool startPixels = false;
    bool found = false;

    // 표준 입력으로부터 데이터를 받습니다.
    while (getline(cin, line)) {
		if (line == "/* columns rows colors chars-per-pixel */") {
            found = true; // 특정 문자열을 찾았습니다.
            cout << line << '\n'; // 이 줄은 변경하지 않고 그대로 출력합니다.
            continue;
        }
		if (found) {
            // 다음 줄에서 색상 수를 변경합니다.
            stringstream ss(line);
            string part;
            vector<string> parts;

            // 공백으로 구분된 문자열을 읽어 벡터에 저장합니다.
            while (getline(ss, part, ' ')) {
                parts.push_back(part);
            }

            if (parts.size() >= 3) {
                // 색상 수(세 번째 요소)를 +1 합니다.
                int colors = stoi(parts[2]) + 1;
                parts[2] = to_string(colors);

                // 변경된 데이터를 출력합니다.
                for (size_t i = 0; i < parts.size(); ++i) {
                    cout << parts[i];
                    if (i < parts.size() - 1) cout << " ";
                }
                cout << '\n';
            }
            found = false; // 다음 줄을 처리했으므로 플래그를 초기화합니다.
			break ;
        }
		else
			cout << line << '\n';
	}
	while (getline(cin, line))
	{
        if (line == "/* pixels */") {
            startPixels = true;
            cout << "\"K c None\",\n" << line << '\n'; // 이 줄은 변경하지 않고 그대로 출력합니다.
            continue;
        }
        if (line == "};")
			break;
        if (startPixels) {
            // 따옴표 내부의 데이터만 추출합니다. 마지막 쉼표 처리는 아래에서 진행합니다.
            if (line.back() == ',') {
                pixels.push_back(line.substr(1, line.size() - 4));
            } else {
                pixels.push_back(line.substr(1, line.size() - 3));
            }
        }
		else
            cout << line << '\n'; // 이 줄은 변경하지 않고 그대로 출력합니다.
    }

    int rows = pixels.size();
    int cols = pixels[0].length();
    vector<vector<bool>> visited(rows, vector<bool>(cols, false));

    queue<pair<int, int>> q;
    q.push({0, 0});
    char targetChar = pixels[0][0];
    pixels[0][0] = 'K'; // 시작 노드를 'K'로 변경
    visited[0][0] = true;

    while (!q.empty()) {
        auto [x, y] = q.front(); q.pop();

        for (int i = 0; i < 4; ++i) {
            int nx = x + dx[i];
            int ny = y + dy[i];

            if (nx < 0 || nx >= rows || ny < 0 || ny >= cols || visited[nx][ny] || pixels[nx][ny] != targetChar)
                continue;

            pixels[nx][ny] = 'K'; // 현재 노드와 같은 문자를 'K'로 변경
            visited[nx][ny] = true;
            q.push({nx, ny});
        }
    }

    // 결과 출력, 마지막 줄을 제외하고 각 줄을 따옴표로 묶고 쉼표를 추가합니다.
    for (size_t i = 0; i < pixels.size(); ++i) {
        cout << "\"";
        for (char c : pixels[i]) {
            cout << c;
        }
        // 마지막 줄을 제외하고 쉼표를 추가
        if (i < pixels.size() - 1) {
            cout << "\",";
        } else {
            cout << "\"" << "\n};";
        }
        cout << '\n';
    }

    return 0;
}
