#!/bin/bash
# ──────────────────────────────────────────────────
# 트친소 자동 좋아요 봇 - 원클릭 설치
# ──────────────────────────────────────────────────
# 사용법: bash setup_x_follower.sh
# ──────────────────────────────────────────────────

set -e

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   트친소 자동 좋아요 + 맞팔로우 봇 설치   ║"
echo "╚══════════════════════════════════════════╝"
echo ""

# ── 1. Python 확인 ──
echo "▶ Python 확인 중..."
if command -v python3 &>/dev/null; then
    PY=python3
elif command -v python &>/dev/null; then
    PY=python
else
    echo "❌ Python이 설치되어 있지 않습니다."
    echo "   https://www.python.org/downloads/ 에서 설치해주세요."
    exit 1
fi
echo "  ✅ $($PY --version)"

# ── 2. pip 확인 & 패키지 설치 ──
echo ""
echo "▶ 필요한 패키지 설치 중..."
$PY -m pip install --upgrade pip -q 2>/dev/null || true
$PY -m pip install -r requirements.txt -q
echo "  ✅ 패키지 설치 완료"

# ── 3. .env 파일 설정 ──
echo ""
if [ -f .env ]; then
    echo "▶ .env 파일이 이미 있습니다. 건너뜁니다."
else
    echo "▶ X API 키를 입력해주세요."
    echo "  (https://developer.x.com/en/portal/dashboard 에서 확인)"
    echo ""

    read -p "  X_API_KEY: " api_key
    read -p "  X_API_SECRET: " api_secret
    read -p "  X_BEARER_TOKEN: " bearer_token
    read -p "  X_ACCESS_TOKEN: " access_token
    read -p "  X_ACCESS_TOKEN_SECRET: " access_token_secret

    cat > .env << EOF
X_API_KEY=${api_key}
X_API_SECRET=${api_secret}
X_BEARER_TOKEN=${bearer_token}
X_ACCESS_TOKEN=${access_token}
X_ACCESS_TOKEN_SECRET=${access_token_secret}
EOF

    echo ""
    echo "  ✅ .env 파일 생성 완료"
fi

# ── 4. 테스트 실행 ──
echo ""
echo "▶ 테스트 실행 (dry-run)..."
echo ""
$PY like_tchinso.py --dry-run
echo ""

# ── 5. cron 등록 (선택) ──
echo ""
echo "──────────────────────────────────────"
read -p "▶ 매일 아침 8시(KST) 자동 실행을 등록할까요? (y/n): " setup_cron

if [ "$setup_cron" = "y" ] || [ "$setup_cron" = "Y" ]; then
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    CRON_CMD="0 23 * * * cd ${SCRIPT_DIR} && ${PY} like_tchinso.py >> like_tchinso.log 2>&1"

    # 중복 등록 방지
    (crontab -l 2>/dev/null | grep -v "like_tchinso.py"; echo "$CRON_CMD") | crontab -

    echo "  ✅ cron 등록 완료! 매일 08:00 KST에 자동 실행됩니다."
    echo "  📄 로그: ${SCRIPT_DIR}/like_tchinso.log"
else
    echo "  ⏭ cron 등록을 건너뛰었습니다."
    echo "  나중에 수동으로 실행: $PY like_tchinso.py"
fi

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║          🎉 설치가 완료되었습니다!          ║"
echo "╠══════════════════════════════════════════╣"
echo "║  실행: $PY like_tchinso.py               ║"
echo "║  테스트: $PY like_tchinso.py --dry-run    ║"
echo "╚══════════════════════════════════════════╝"
echo ""
